local name, ns = ...

local settings = ns.settings

local function getFormattedText(unitToken)
    if not settings.IsHealthLabelEnabled() then return "" end

    local text = settings.GetHealthFormat()

    local name = UnitName(unitToken)
    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)

    local healthPercent = math.floor((health / maxHealth) * 100)
    local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
    local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

    text = text:gsub("%%NAME%%", tostring(name))
    text = text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
    text = text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
    text = text:gsub("%%PERCENT2%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

    local deficit = health - maxHealth
    local deficitStr = deficit ~= 0 and tostring(deficit) or ""

    text = text:gsub("%%DEFICIT%%", deficitStr)
    text = text:gsub("%%CURRENT%%", tostring(health))
    text = text:gsub("%%MAX%%", tostring(maxHealth))

    return text
end

local function updateHealthLabel(unitToken)
    local text = getFormattedText(unitToken)
    BNPBus:TriggerEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", unitToken, text)
end

local function onUnitHealth(_, unitToken)
    updateHealthLabel(unitToken)
end

local function onHealthLabelReady(_, unitToken)
    updateHealthLabel(unitToken)
end

local function onSettingsChanged(_, key)
    if (key == "displayHealth") then
        for _, namePlate in pairs(ns:GetAllNameplates()) do
            local unitToken = namePlate.UnitFrame.unitToken
            if not unitToken then return end
            updateHealthLabel(unitToken)
        end
    elseif (key == "healthFormat") then
        for _, namePlate in pairs(ns:GetAllNameplates()) do
            local unitToken = namePlate.UnitFrame.unitToken
            if not unitToken then return end
            updateHealthLabel(unitToken)
        end
    end
end

BNPBus:RegisterEvent("UNIT_HEALTH", onUnitHealth)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_HEALTH_LABEL_READY", onHealthLabelReady)
BNPBus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)