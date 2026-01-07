local name, ns = ...

local settings = ns.settings

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local unitFramme = driverFrame.UnitFrame
    if not unitFramme then return end

    if not ns.units[namePlateUnitToken] then
        ns.units[namePlateUnitToken] = {}
        ns.units[namePlateUnitToken].frame = unitFramme
        ns.units[namePlateUnitToken].healthBar = unitFramme.healthBar
    end

    ns:TriggerEvent(name .. "_NAMEPLATE_CACHED", unitFramme, namePlateUnitToken)
end

local function toggleShowClassColorInNameplateCVar()
    local state = settings.IsUsingCVarsEnabled() and "1" or "0"
    SetCVar("ShowClassColorInNameplate", state)
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
    elseif (key == "cVarClassColor") then   
        toggleShowClassColorInNameplateCVar()
    end
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)