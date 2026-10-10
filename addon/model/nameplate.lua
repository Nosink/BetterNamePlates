local name, ns = ...

local includeForbidden = false

local function getFormattedText(unitToken)
    if not ns.db.displayHealth then return "NO HEALTH" end

    local text = ns.db.healthFormat or "%PERCENT1%"

    local name = UnitName(unitToken)
    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)

    local healthPercent = math.floor((health / maxHealth) * 100)
    local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
    local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

    text = text:gsub("%%NAME%%", tostring(name))
    text = text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
    text = text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
    text = text:gsub("%%PERCENT2%%",
        tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

    local deficit = health - maxHealth
    local deficitStr = deficit ~= 0 and tostring(deficit) or ""

    text = text:gsub("%%DEFICIT%%", deficitStr)
    text = text:gsub("%%CURRENT%%", tostring(health))
    text = text:gsub("%%MAX%%", tostring(maxHealth))

    return text
end

local function createHealthLabel(nameplate)
    if nameplate.UnitFrame.HealthLabel then return end

    local healthBar = nameplate.UnitFrame.healthBar
    if not healthBar then return end

    local healthLabel = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthLabel:SetPoint("LEFT", healthBar, "LEFT", 1, 0)

    healthLabel.UpdateFontSize = function(self)
        local file, _, flags = self:GetFont()
        self:SetFont(tostring(file), 10, flags)
    end

    healthLabel:UpdateFontSize()

    healthLabel:SetJustifyV("MIDDLE")
    healthLabel:SetJustifyH("LEFT")
    healthLabel:SetTextColor(1, 1, 1, 1)

    healthLabel.UpdateText = function(self)
        local text = getFormattedText(nameplate.namePlateUnitToken)
        self:SetText(text)
        self:Show();
    end

    healthLabel:UpdateText()

    nameplate.UnitFrame.HealthLabel = healthLabel
end

local function onNamePlateAdded(_, unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, includeForbidden)

    createHealthLabel(nameplate)

    ns.bus:TriggerEvent(name .. "_NAME_PLATE_READY", nameplate)
end

ns.bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
