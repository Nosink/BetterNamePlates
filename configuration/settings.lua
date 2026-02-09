local _, ns = ...

ns.settings = ns.settings or {}

local defaultFontSize = 9
local mindefaultFontSize = 6

function ns.settings.IsHealthLabelEnabled()
    return ns.database.displayHealth
end

function ns.settings.GetHealthFormat()
    return ns.database.healthFormat
end

function ns.settings.GetFontSize()
    local fontSize = tonumber(ns.database.fontSize) or defaultFontSize
    return max(fontSize or mindefaultFontSize, mindefaultFontSize)
end

function ns.settings.IsCastLabelEnabled()
    return ns.database.displayCast
end