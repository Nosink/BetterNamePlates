local name, ns = ...

local function onNamePlateCached(_, unit)
    if not unit.healthBar.label then
        EventBus:TriggerEvent(name .. "_HEALTH_LABEL_REQUEST", unit)
    end
    if not unit.ticker then
        EventBus:TriggerEvent(name .. "_HEALTH_TICKER_REQUEST", unit)
    end
end

EventBus:RegisterEvent(name .. "_NAMEPLATE_CACHED", onNamePlateCached)