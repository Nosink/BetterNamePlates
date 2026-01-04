local name, ns = ...

local function initializeVars()
    ns.units = {}
end

local function onAddonLoaded()

    initializeVars()

    ns:TriggerEvent(name .. "_ADDON_LOADED")
end

ns:RegisterEvent("ADDON_LOADED", onAddonLoaded)