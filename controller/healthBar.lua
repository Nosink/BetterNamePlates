local name, ns = ...

local settings = ns.settings

local function getFormattedText(unitToken)
    local text = settings.GetHealthFormat()

    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)

    local healthPercent = math.floor((health / maxHealth) * 100)
    local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
    local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

    text = text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
    text = text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
    text = text:gsub("%%PERCENT2%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

    text = text:gsub("%%CURRENT%%", tostring(health))
    text = text:gsub("%%MAX%%", tostring(maxHealth))

    return text
end

local function onUnitHealth(_, unitToken)
    local text = getFormattedText(unitToken)
    BNPBus:TriggerEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", unitToken, text)
end

local function onHealthLabelReady(_, unitToken)
    onUnitHealth(nil, unitToken)
end

BNPBus:RegisterEvent("UNIT_HEALTH", onUnitHealth)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_HEALTH_LABEL_READY", onHealthLabelReady)