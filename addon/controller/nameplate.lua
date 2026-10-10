local name, ns = ...

local function updateNamePlatesColor()
    C_CVar.SetCVar("nameplateShowFriendlyClassColor", tostring(ns.db.coloredNameplates))
    C_CVar.SetCVar("nameplateShowClassColor", tostring(ns.db.enemyColoredNameplates))
end
local function setFirstLoad()
    ns.db.isFirstLoad = false
end

local function onVariablesLoaded(_)
    if not ns.db.isFirstLoad then return end

    setFirstLoad()
    updateNamePlatesColor()
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)

local function onSettingsChanged(_, key)
    if (key == "coloredNameplates" or key == "enemyColoredNameplates") then
        updateNamePlatesColor()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
