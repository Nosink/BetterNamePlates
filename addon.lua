local name, ns = ...

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

    ns:TriggerEvent(name .. "_ADDON_LOADED")
end

ns:RegisterEvent("ADDON_LOADED", onAddonLoaded)