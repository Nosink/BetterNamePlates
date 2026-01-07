local name, ns = ...

local function onNamePlateData(_, _, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit then return end

    unit.text = ""

    if not unit.label then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", namePlateUnitToken)
    end
    if not unit.ticker then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", namePlateUnitToken)
    end
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)
