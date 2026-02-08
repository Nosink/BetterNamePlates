local name, ns = ...

local LibEventBus = LibStub("LibEventBus-1.0")
BNPBus = LibEventBus:NewBus("BNPBus", true)

function ns:GetNamePlate(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, issecure())
    if not nameplate then return end

    return nameplate
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    BNPBus:TriggerEvent(name .. "_ADDON_LOADED")
end

BNPBus:RegisterEvent("ADDON_LOADED", onAddonLoaded)