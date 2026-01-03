local _, ns = ...

ns.settings = ns.settings or {}

-- Class Color
function ns.settings.IsClassColorEnabled()
    return ns.database.classColor
end