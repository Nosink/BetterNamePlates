local name, ns = ...

local function updateNamePlatesColor()
    C_CVar.SetCVar("nameplateShowFriendlyClassColor", tostring(ns.db.coloredNameplates))
    C_CVar.SetCVar("nameplateShowClassColor", tostring(ns.db.enemyColoredNameplates))
end

local function onVariablesLoaded(_)
    if not ns.db.isFirstLoad then return end

    updateNamePlatesColor()
    ns.db.isFirstLoad = false
end

local function onNamePlateAdded(_, unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, true)
    ns.bus:TriggerEvent(name .. "_NAME_PLATE_UNIT_ADDED", nameplate)
end

ns.bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)

local function onSettingsChanged(_, key)
    if (key == "coloredNameplates" or key == "enemyColoredNameplates") then
        updateNamePlatesColor()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
