local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthTickerRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit then return end

    unit.CreateTicker = function (self)
        self.ticker = C_Timer.NewTicker(0.1, function()
            local unitInfo = UnitGUID(namePlateUnitToken)
            if not unitInfo then self:ClearTicker() return end

            unit.text = settings.GetHealthFormat()

            local health = UnitHealth(namePlateUnitToken)
            local maxHealth = UnitHealthMax(namePlateUnitToken)
            local healthPercent = math.floor((health / maxHealth) * 100)
            local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
            local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

            unit.text = unit.text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
            unit.text = unit.text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
            unit.text = unit.text:gsub("%%PERCENT2%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

            unit.text = unit.text:gsub("%%CURRENT%%", tostring(health))
            unit.text = unit.text:gsub("%%MAX%%", tostring(maxHealth))

            ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_UPDATE_REQUEST", namePlateUnitToken)
        end)
    end

    unit.ClearTicker = function (self)
        if self.ticker then
            self.ticker:Cancel()
            self.ticker = nil
        end
    end

    unit:CreateTicker()

end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", onNamePlateHealthTickerRequest)