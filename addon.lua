local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

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

    bus:TriggerEvent(name .. "_ADDON_LOADED")
end

bus:RegisterEvent("ADDON_LOADED", onAddonLoaded)