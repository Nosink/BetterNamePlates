local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthTickerRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    ns.units[namePlateUnitToken].ticker =  C_Timer.NewTicker(0.1, function()
        
        unit.text = settings.GetHealthFormat()

        local health = UnitHealth(namePlateUnitToken)        
        local maxHealth = UnitHealthMax(namePlateUnitToken)
        local healthPercentPoint = 10 and unit.text:find("%%PERCENT1%%") or 1
        healthPercentPoint = 100 and unit.text:find("%%PERCENT2%%") or healthPercentPoint
        local extra = 0.5
        if healthPercentPoint == 1 then
            extra = 0
        end
        local healthPercent = math.floor(((health / maxHealth) * 100) * healthPercentPoint + extra) / healthPercentPoint

        if (unit.text:find("%%PERCENT1%%")) then
            unit.text = unit.text:gsub("%%PERCENT1%%", tostring(healthPercent))
        elseif (unit.text:find("%%PERCENT2%%")) then
            unit.text = unit.text:gsub("%%PERCENT2%%", tostring(healthPercent))
        elseif (unit.text:find("%%PERCENT%%")) then
            unit.text = unit.text:gsub("%%PERCENT%%", tostring(healthPercent))
        end

        unit.text = unit.text:gsub("%%CURRENT%%", tostring(health))
        unit.text = unit.text:gsub("%%MAX%%", tostring(maxHealth))

        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", namePlateUnitToken)
    end)
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", onNamePlateHealthTickerRequest)