local name, ns = ...

local function onAddonLoaded()
    ns:TriggerEvent(name .. "_ADDON_LOADED")
end

ns:RegisterEvent("ADDON_LOADED", onAddonLoaded)