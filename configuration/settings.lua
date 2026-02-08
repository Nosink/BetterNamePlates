local _, ns = ...

ns.settings = ns.settings or {}

local defaultFontSize = 10
local mindefaultFontSize = 6

function ns.settings.IsUsingCVarsEnabled()
    return ns.database.cVarClassColor
end

function ns.settings.IsHealthDisplayEnabled()
    return ns.database.displayHealth
end

function ns.settings.GetHealthFormat()
    return ns.database.healthFormat
end

function ns.settings.GetRefreshRate()
    return ns.database.refreshRate
end

function ns.settings.GetFontSize()
    local fontSize = tonumber(ns.database.fontSize) or defaultFontSize
    return max(fontSize or mindefaultFontSize, mindefaultFontSize)
end

function ns.settings.IsCastDisplayEnabled()
    return ns.database.displayCast
end