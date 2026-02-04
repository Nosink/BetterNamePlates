local name, ns = ...

local LibSnow = LibStub("LibSnow")
EventBus = LibSnow:GetModule("EventBus")

local function initializeVars()
    ns.namePlates = {}
    function ns.AddNamePlate(unitToken, namePlate)
        ns.namePlates[unitToken] = namePlate
    end
    function ns.GetNamePlate(unitToken)
        return ns.namePlates[unitToken]
    end

end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    initializeVars()

    EventBus:TriggerEvent(name .. "_ADDON_LOADED")
end

EventBus:RegisterEvent("ADDON_LOADED", onAddonLoaded)