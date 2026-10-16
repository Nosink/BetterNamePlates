local name, ns = ...

local includeForbidden = true

local function updateNamePlatesColor()
    C_CVar.SetCVar("nameplateShowFriendlyClassColor", tostring(ns.db.coloredNameplates))
    C_CVar.SetCVar("nameplateShowClassColor", tostring(ns.db.enemyColoredNameplates))
end


local function setFirstLoad()
    ns.db.isFirstLoad = false
end

local function onVariablesLoaded(_)
    if not ns.db.isFirstLoad then return end

    setFirstLoad()
    updateNamePlatesColor()
end
local function getNameplate(unitToken)
    return C_NamePlate.GetNamePlateForUnit(unitToken, includeForbidden)
end

local function onUnitHealth(_, unitToken)
    local nameplate = getNameplate(unitToken)
    ns.bus:TriggerEvent(name .. "_UNIT_HEALTH", unitToken, nameplate)
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
ns.bus:RegisterEvent("UNIT_HEALTH", onUnitHealth)
ns.bus:RegisterEvent("UNIT_HEALTH_FREQUENT", onUnitHealth)

local function onSettingsChanged(_, key)
    if (key == "coloredNameplates" or key == "enemyColoredNameplates") then
        updateNamePlatesColor()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
