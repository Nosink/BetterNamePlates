local name, _ = ...

local function onVariablesLoaded(_)
    if GetCVar("ShowClassColorInFriendlyNameplate") == "0" then
        BNPBus:TriggerEvent(name .. "_CLASS_COLOR_CVAR_DISABLED")
    end
end

local function onEnableCvarRequested(_)
    SetCVar("ShowClassColorInFriendlyNameplate", "1")
    ReloadUI()
end

local function onNamePlateAdded(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
end

local function onNamePlateRemoved(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_REMOVED", unitToken)
end

BNPBus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
BNPBus:RegisterEvent(name .. "_ENABLE_CVAR_REQUEST", onEnableCvarRequested)

BNPBus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
BNPBus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)