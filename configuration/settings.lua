local name, ns = ...

ns.settings = ns.settings or {}

local defaultFontSize = 9
local mindefaultFontSize = 6
local defaultRefreshRate = 0.2

-- Class Color
function ns.settings.IsClassColorEnabled()
    return ns.database.classColor
end

function ns.settings.IsUsingCVarsEnabled()
    return ns.database.cVarClassColor
end

function ns.settings.IsClassColoredEnabledUsingCVars()
    return ns.settings.customHealthColorBars
end

function ns.settings.IsShamanColorEnabled()
    return ns.database.shamanColor
end

function ns.settings.GetUnitClassName(unit)
    local class = UnitClassBase(unit)
    class = "PALADIN" and class
    if not ns.database.shamanColor and class == "SHAMAN" then
        class = "PALADIN"
    end
    return class
end

-- Health
function ns.settings.IsHealthDisplayEnabled()
    return ns.database.displayHealth
end

function ns.settings.GetHealthFormat()
    return ns.database.healthFormat
end

function ns.settings.GetRefreshRate()
    return ns.database.refreshRate or defaultRefreshRate
end

function ns.settings.GetFontSize()
    local fontSize = tonumber(ns.database.fontSize)
    if not fontSize then
        fontSize = defaultFontSize
    end
    return max(fontSize or mindefaultFontSize, mindefaultFontSize)
end

local function onLoadVariables()
    ns.settings.customHealthColorBars = ns.database.cVarClassColor
end

ns:RegisterEvent(name .. "_VARIABLES_LOADED", onLoadVariables)