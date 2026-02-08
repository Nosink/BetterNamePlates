local name, _ = ...

local function onNamePlateAdded(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
end

local function onNamePlateRemoved(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_REMOVED", unitToken)
end

BNPBus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
BNPBus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)