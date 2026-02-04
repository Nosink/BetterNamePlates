local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

local function onNamePlateCached(_, unit)
    if not unit.healthBar.label then
        bus:TriggerEvent(name .. "_HEALTH_LABEL_REQUEST", unit)
    end
    if not unit.ticker then
        bus:TriggerEvent(name .. "_HEALTH_TICKER_REQUEST", unit)
    end
end

bus:RegisterEvent(name .. "_NAMEPLATE_CACHED", onNamePlateCached)