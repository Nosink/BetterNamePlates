local name, ns = ...

local function onNamePlateCached(_, _, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit then return end

    if not unit.label then
        ns:TriggerEvent(name .. "_HEALTH_LABEL_REQUEST", namePlateUnitToken)
    end
    if not unit.ticker then
        ns:TriggerEvent(name .. "_HEALTH_TICKER_REQUEST", namePlateUnitToken)
    end
end

ns:RegisterEvent(name .. "_NAMEPLATE_CACHED", onNamePlateCached)