local name, ns = ...

local settings = ns.settings


local function onAddonLoaded(_)
end

local function onSettingChanged(_, key)
end

ns:RegisterEvent(name .. "_ADDON_LOADED", onAddonLoaded)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingChanged)