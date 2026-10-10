local name, ns = ...

local settings = ns.settings



local function onNamePlateReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local UnitFrame = namePlate.UnitFrame or nil
    if not UnitFrame then return end

    if not UnitFrame.healthLabel then
        createHealthLabel(UnitFrame, UnitFrame.healthBar)
    end

    ns.bus:TriggerEvent(name .. "_NAME_PLATE_HEALTH_LABEL_READY", unitToken)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)
