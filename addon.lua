local name, ns = ...

local function initializeVars()
    ns.namePlates = {}
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    initializeVars()

    ns:TriggerEvent(name .. "_ADDON_LOADED")
end

ns:RegisterEvent("ADDON_LOADED", onAddonLoaded)