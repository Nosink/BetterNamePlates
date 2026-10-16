local name, ns = ...

local enums = ns.enums

local function getFormattedText(unitToken)
    if ns.db.displayHealth == "0" then return "" end

    local isPlayer = UnitIsPlayer(unitToken)
    local isNeutral = UnitReaction(unitToken, "player") > enums.reaction.NEUTRAL

    if ns.db.displayHealth == "1" and isNeutral and not isPlayer then return "" end
    if ns.db.displayHealth == "2" and isPlayer then return "" end

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

local function updateHealthText(_, nameplate)
    local text = getFormattedText(nameplate.unitToken)
    ns.bus:TriggerEvent(name .. "_UPDATE_NAMEPLATE_HEALTH", nameplate, text)
end

ns.bus:RegisterEvent(name .. "_UNIT_HEALTH", updateHealthText)
ns.bus:RegisterEvent(name .. "_NAME_PLATE_UNIT_ADDED", updateHealthText)

local function onSettingsChanged(_, key)
    if (key == "fontSize") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            ns.bus:TriggerEvent(name .. "_UPDATE_NAMEPLATE_HEALTH_SIZE", nameplate)
        end
    end
    if (key == "healthFormat" or key == "displayHealth") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            updateHealthText(_, nameplate)
        end
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
