local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

local data = ns.data
local settings = ns.settings

local function onNamePlateCached(_, unit)

    local guid = UnitGUID(unit.token)
    local friendly = UnitIsFriend("player", unit.token)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" or not friendly then return end

    local class = settings.GetUnitClassName(unit.token)
    unit.color = data.classColor[class]

    if settings.IsClassColoredEnabledUsingCVars() then
        return
    end
    if not settings.IsClassColorEnabled() then return end

    bus:TriggerEvent(name .. "_COLOR_UPDATE_REQUEST", unit)
end

bus:RegisterEvent(name .. "_NAMEPLATE_CACHED", onNamePlateCached)