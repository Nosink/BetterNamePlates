local name, ns = ...

local function onNamePlateData(_, _, namePlateUnitToken)
    ns.units[namePlateUnitToken].text = ""

    if not ns.units[namePlateUnitToken].label then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", namePlateUnitToken)
    end
    if not ns.units[namePlateUnitToken].ticker then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", namePlateUnitToken)
    end
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)
