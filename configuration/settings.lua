local _, ns = ...

ns.settings = ns.settings or {}

-- Class Color
function ns.settings.IsClassColorEnabled()
    return ns.database.classColor
end

function ns.settings.IsShamanColorEnabled()
    return ns.database.shamanColor
end

-- Health
function ns.settings.IsHealthDisplayEnabled()
    return ns.database.displayHealth
end

function ns.settings.GetHealthFormat()
    return ns.database.healthFormat
end