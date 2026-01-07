local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthTickerRequest(_, namePlateUnitToken)
    if not ns.units[namePlateUnitToken] then return end

    ns.units[namePlateUnitToken].CreateTicker = function (self)
        self.ticker = C_Timer.NewTicker(0.1, function()
            local unitInfo = UnitGUID(namePlateUnitToken)
            if not unitInfo then self:ClearTicker() return end

            ns.units[namePlateUnitToken].text = settings.GetHealthFormat()

            local health = UnitHealth(namePlateUnitToken)
            local maxHealth = UnitHealthMax(namePlateUnitToken)
            local healthPercent = math.floor((health / maxHealth) * 100)
            local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
            local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

            ns.units[namePlateUnitToken].text = ns.units[namePlateUnitToken].text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
            ns.units[namePlateUnitToken].text = ns.units[namePlateUnitToken].text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
            ns.units[namePlateUnitToken].text = ns.units[namePlateUnitToken].text:gsub("%%PERCENT2%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

            ns.units[namePlateUnitToken].text = ns.units[namePlateUnitToken].text:gsub("%%CURRENT%%", tostring(health))
            ns.units[namePlateUnitToken].text = ns.units[namePlateUnitToken].text:gsub("%%MAX%%", tostring(maxHealth))

            ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_UPDATE_REQUEST", namePlateUnitToken)
        end)
    end

    ns.units[namePlateUnitToken].ClearTicker = function (self)
        if self.ticker then
            self.ticker:Cancel()
            self.ticker = nil
        end
    end

    ns.units[namePlateUnitToken]:CreateTicker()

end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", onNamePlateHealthTickerRequest)