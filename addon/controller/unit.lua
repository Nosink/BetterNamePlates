local name, ns = ...

local function onUnitHealth(_, unitToken)
    if not unitToken:match("^nameplate") then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, true)
    ns.bus:TriggerEvent(name .. "_UNIT_HEALTH", nameplate)
end

ns.bus:RegisterEvent("UNIT_HEALTH", onUnitHealth)
