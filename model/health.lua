local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthTickerRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    ns.units[namePlateUnitToken].ticker =  C_Timer.NewTicker(0.1, function()

        local health = UnitHealth(namePlateUnitToken)        
        local maxHealth = UnitHealthMax(namePlateUnitToken)
        local healthPercent = (maxHealth == 0) and 0 or (health / maxHealth) * 100

        unit.text = settings.GetHealthFormat()

        unit.text = unit.text:gsub("%%PERCENT%%", tostring(healthPercent))
        unit.text = unit.text:gsub("%%CURRENT%%", tostring(health))
        unit.text = unit.text:gsub("%%MAX%%", tostring(maxHealth))

        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", namePlateUnitToken)
    end)
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", onNamePlateHealthTickerRequest)