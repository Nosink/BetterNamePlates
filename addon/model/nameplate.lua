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

local function getCastInfo(unitToken)
    local name, _, _, startTimeMs, endTimeMs = UnitCastingInfo(unitToken)
    if not name then
        name, _, _, startTimeMs, endTimeMs = UnitChannelInfo(unitToken)
    end
    if not name then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs

    return name -- string.format("%.1f/%.1f", elapsed / 1000, duration / 1000)
end

local function createCastLabel(nameplate)
    if nameplate.UnitFrame.CastLabel then return end

    local castBar = nameplate.UnitFrame.CastBarsContainer.castBar
    if not castBar then return end

    local labelFrame = CreateFrame("Frame", nil, nameplate.UnitFrame.CastBarsContainer)
    labelFrame:SetAllPoints(castBar)
    labelFrame:SetFrameStrata("HIGH")

    local castLabel = labelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    castLabel:SetPoint("RIGHT", castBar, "RIGHT", -5, 0)

    local file, _, flags = castLabel:GetFont()
    castLabel:SetFont(tostring(file), 10, flags)

    castLabel:SetJustifyV("MIDDLE")
    castLabel:SetJustifyH("RIGHT")
    castLabel:SetTextColor(1, 1, 1, 1)
    local text = getCastInfo(nameplate.unitToken)
    castLabel:SetText(text)

    castLabel:Hide()

    nameplate.UnitFrame.CastLabel = castLabel

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnShow", function()
        nameplate.UnitFrame.CastLabel:Show()
    end)

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnHide", function()
        nameplate.UnitFrame.CastLabel:Hide()
    end)
end

local function createHealthLabel(nameplate)
    if nameplate.UnitFrame.HealthLabel then return end

    local healthBar = nameplate.UnitFrame.healthBar
    if not healthBar then return end

    local healthLabel = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalOutline")
    healthLabel:SetPoint("LEFT", healthBar, "LEFT", 5, -1)

    healthLabel.UpdateFontSize = function(self)
        local file, _, flags = self:GetFont()
        self:SetFont(tostring(file), tonumber(ns.db.fontSize), flags)
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

local function getNameplate(unitToken)
    return C_NamePlate.GetNamePlateForUnit(unitToken, includeForbidden)
end

local function onNamePlateAdded(_, unitToken)
    local nameplate = getNameplate(unitToken)
    if not nameplate then
        print("Nameplate not found for unit: " .. unitToken)
        return
    end

    createHealthLabel(nameplate)
    createCastLabel(nameplate)

    ns.bus:TriggerEvent(name .. "_NAME_PLATE_READY", nameplate)
end

ns.bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)

local function onUnitHealth(_, unitToken)
    local nameplate = getNameplate(unitToken)
    if not nameplate then return end

    ns.bus:TriggerEvent(name .. "_UPDATE_HEALTH", nameplate)
end

ns.bus:RegisterEvent("UNIT_HEALTH", onUnitHealth)
