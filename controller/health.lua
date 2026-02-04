local name, ns = ...

local settings = ns.settings

local bus = LibStub("LibEventBus-1.0")

local function onNamePlateHealthTickerRequest(_, unit)
    if not unit then return end

    unit.CreateTicker = function (self)
        self.ticker = C_Timer.NewTicker(settings.GetRefreshRate(), function()
            local guid = UnitGUID(self.token)
            if not guid then self:ClearTicker() return end

            self.text = settings.GetHealthFormat()

            local health = UnitHealth(self.token)
            local maxHealth = UnitHealthMax(self.token)
            local healthPercent = math.floor((health / maxHealth) * 100)
            local firstDecimal = math.floor(((health / maxHealth) * 1000) % 10)
            local secondDecimal = math.floor(((health / maxHealth) * 10000) % 10)

            self.text = self.text:gsub("%%PERCENT%%", tostring(healthPercent) .. "%%")
            self.text = self.text:gsub("%%PERCENT1%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. "%%")
            self.text = self.text:gsub("%%PERCENT2%%", tostring(healthPercent) .. "." .. tostring(firstDecimal) .. tostring(secondDecimal) .. "%%")

            self.text = self.text:gsub("%%CURRENT%%", tostring(health))
            self.text = self.text:gsub("%%MAX%%", tostring(maxHealth))

            bus:TriggerEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", unit)
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

bus:RegisterEvent(name .. "_HEALTH_TICKER_REQUEST", onNamePlateHealthTickerRequest)