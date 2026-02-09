local name, ns = ...

local LibEventBus = LibStub("LibEventBus-1.0")
BNPBus = LibEventBus:NewBus("BNPBus", true)

function ns:GetNamePlate(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken)
    if not nameplate then return end
    return nameplate
end

function ns:GetAllNameplates()
    local nameplates = {}
    for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
        table.insert(nameplates, nameplate)
    end
    return nameplates
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    BNPBus:TriggerEvent(name .. "_ADDON_LOADED")
end

BNPBus:RegisterEvent("ADDON_LOADED", onAddonLoaded)