local name, ns = ...

local data = ns.data
local settings = ns.settings

local function onNamePlateData(_, healthBar, classFilename)
    local color = {r = 0, g = 0, b = 1}
    if settings.IsClassColorEnabled() then
        color = data.classColor[classFilename]
    end
    ns:TriggerEvent(name .. "_NAMEPLATE_UPDATE", healthBar, color)
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)
ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateData)