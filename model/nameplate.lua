local name, ns = ...

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local guid = UnitGUID(namePlateUnitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local healthBar = driverFrame.UnitFrame.healthBar
    local classFilename = UnitClassBase(namePlateUnitToken)

    ns:TriggerEvent(name .. "_NAMEPLATE_DATA", healthBar, classFilename)
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