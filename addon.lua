local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

function ns:GetNamePlate(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, issecure())
    if not nameplate then return end

    return nameplate
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    bus:TriggerEvent(name .. "_ADDON_LOADED")
end

bus:RegisterEvent("ADDON_LOADED", onAddonLoaded)