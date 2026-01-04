local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthLabelReady(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit then return end

    local label = unit.label
    if not label then return end

    unit.ticker = C_Timer.NewTicker(0, function()
        local health = UnitHealth(namePlateUnitToken)
        if health == nil or health == 0 then return end

        local maxHealth = UnitHealthMax(namePlateUnitToken)
        local healthPercent = (maxHealth == 0) and 0 or (health / maxHealth) * 100
        local healthFormat = settings.GetHealthFormat()
        healthFormat = healthFormat:gsub("%%PERCENT%%", tostring(healthPercent))
        healthFormat = healthFormat:gsub("%%CURRENT%%", tostring(health))
        healthFormat = healthFormat:gsub("%%MAX%%", tostring(maxHealth))
        label:SetText(healthFormat)
    end)

end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_READY", onNamePlateHealthLabelReady)