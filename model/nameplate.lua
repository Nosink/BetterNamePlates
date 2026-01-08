local name, ns = ...

local settings = ns.settings

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local unitFramme = driverFrame.UnitFrame
    if not unitFramme then return end

    local unit = {}
    unit.token = namePlateUnitToken
    unit.frame = unitFramme
    unit.healthBar = unitFramme.healthBar

    ns.activePlates[namePlateUnitToken] = unit

    ns:TriggerEvent(name .. "_NAMEPLATE_CACHED", unit)
end

local function onNamePlateRemoved(_)
    local ActiveNamePlates = C_NamePlate.GetNamePlates()
    local removedPlaes = ns.activePlates
    for _, activePlate in pairs(ActiveNamePlates) do
        removedPlaes[activePlate.namePlateUnitToken] = nil
    end
    for namePlateUnitToken, _ in pairs(removedPlaes) do
        local unit = ns.activePlates[namePlateUnitToken]
        if unit.RestoreColor then unit:RestoreColor() end
        unit.healthBar.label:SetText("")
        unit:ClearTicker()
        ns.activePlates[namePlateUnitToken] = nil
    end
end

local function toggleShowClassColorInNameplateCVar()
    local state = settings.IsUsingCVarsEnabled() and 1 or 0
    SetCVar("ShowClassColorInFriendlyNameplate", state)

end

local function onSettingsChanged(_, key)
    if (key == "classColor") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            if settings.IsClassColorEnabled() then
                onNamePlateAdded(namePlate, namePlate.namePlateUnitToken)
            else
                local unit = ns.activePlates[namePlate.namePlateUnitToken]
                if unit and unit.RestoreColor then
                    unit:RestoreColor()
                end
            end
        end
    elseif (key == "shamanColor") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            onNamePlateAdded(namePlate, namePlate.namePlateUnitToken)
        end
    elseif (key == "displayHealth") then

    elseif (key == "cVarClassColor") then
        toggleShowClassColorInNameplateCVar()
    end
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)
ns:HookSecureFunc(NamePlateBaseMixin, "OnRemoved", onNamePlateRemoved)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)