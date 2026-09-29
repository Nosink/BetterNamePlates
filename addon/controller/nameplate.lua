local name, ns = ...

local function onVariablesLoaded(_)
    if GetCVar("ShowClassColorInFriendlyNameplate") == "0" then
        ns.bus:TriggerEvent(name .. "_CLASS_COLOR_CVAR_DISABLED")
    end
end

local function onEnableCvarRequested(_)
    SetCVar("ShowClassColorInFriendlyNameplate", "1")
    ReloadUI()
end

local function onNamePlateAdded(_, unitToken)
    ns.bus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
end

local function onNamePlateRemoved(_, unitToken)
    ns.bus:TriggerEvent(name .. "_NAME_PLATE_REMOVED", unitToken)
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
ns.bus:RegisterEvent(name .. "_ENABLE_CVAR_REQUEST", onEnableCvarRequested)

ns.bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
ns.bus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)
