local name, ns = ...

local function onNamePlateAdded(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local UnitFrame = namePlate.UnitFrame or nil
    if not UnitFrame then return end

    UnitFrame.unitToken = unitToken

    ns.bus:TriggerEvent(name .. "_NAME_PLATE_READY", unitToken)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_ADDED", onNamePlateAdded)
