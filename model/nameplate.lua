local name, ns = ...

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local healthBar = driverFrame.UnitFrame.healthBar
    ns:TriggerEvent(name .. "_NAMEPLATE_DATA", healthBar, namePlateUnitToken)
end

local function onSettingsChanged(_, key)
    if (key == "classColor") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            onNamePlateAdded(namePlate, namePlate.namePlateUnitToken)
        end
    elseif (key == "shamanColor") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            local classFilename = UnitClassBase(namePlate.namePlateUnitToken)
            if classFilename == "SHAMAN" then
                onNamePlateAdded(namePlate, namePlate.namePlateUnitToken)
            end
        end
    end
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)