local name, ns = ...

local includeForbidden = false

local function getFormattedText(unitToken)
    if not ns.db.displayHealth then return "" end

    local text = ns.db.healthFormat or "%PERCENT1%"

    local name = UnitName(unitToken)
    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)
    local rawHealthPercent = UnitHealthPercent(unitToken)
    local percentPoint = "%.0f"
    if (ns.db.healthFormat:find("%%PERCENT1%%")) then
        percentPoint = "%.1f"
    elseif (ns.db.healthFormat:find("%%PERCENT2%%")) then
        percentPoint = "%.2f"
    end
    local healthPercent = string.format(percentPoint, rawHealthPercent * 100) .. "%%"
    local missing = UnitHealthMissing(unitToken)
    local deficit = missing ~= 0 and "-" .. tostring(missing) or ""

    text = text:gsub("%%NAME%%", name)
    text = text:gsub("%%PERCENT%%", healthPercent)
    text = text:gsub("%%PERCENT1%%", healthPercent)
    text = text:gsub("%%PERCENT2%%", healthPercent)

    text = text:gsub("%%CURRENT%%", health)
    text = text:gsub("%%MAX%%", maxHealth)
    text = text:gsub("%%MISSING%%", deficit)

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
        local text = getFormattedText(nameplate.unitToken)
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
