---@diagnostic disable: undefined-field

local name, ns = ...

local settings = ns.settings

local function onNamePlateData(_, healthBar, namePlateUnitToken)
    ns.units[namePlateUnitToken] = ns.units[namePlateUnitToken] or { healthBar = healthBar }
    if not ns.units[namePlateUnitToken].label then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", namePlateUnitToken)
    end
end

local function onNamePlateHealthLabelReady(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]

    if unit.ticker then
        unit.ticker:Cancel()
        unit.ticker = nil
    end

    if settings.IsHealthDisplayEnabled() then
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_TICKER_REQUEST", namePlateUnitToken)
    else
        unit.text = ""
        ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", namePlateUnitToken)
    end
end

local function onSettingsChanged(_, key)
    if (key == "displayHealth") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            local healthBar = namePlate.UnitFrame.healthBar
            onNamePlateData(nil, healthBar, namePlate.namePlateUnitToken)
            onNamePlateHealthLabelReady(nil, namePlate.namePlateUnitToken)
        end
    end
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)
ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_READY", onNamePlateHealthLabelReady)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)