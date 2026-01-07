local name, ns = ...

local data = ns.data
local settings = ns.settings

local function onNamePlateData(_, namePlateUnitToken)
    if settings.IsClassColoredEnabledUsingCVars() then return end
    if not settings.IsClassColorEnabled() then return end

    local guid = UnitGUID(namePlateUnitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local class = settings.GetUnitClassName(namePlateUnitToken)
    ns.units[namePlateUnitToken].color = data.classColor[class]

    ns:TriggerEvent(name .. "_NAMEPLATE_COLOR_UPDATE_REQUEST", namePlateUnitToken)
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)