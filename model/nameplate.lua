local name, ns = ...

local settings = ns.settings

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local unitFrame = driverFrame.UnitFrame
    if not unitFrame then return end

    local namePlate = ns.GetNamePlate(namePlateUnitToken)

    if not namePlate then
        namePlate = {}
        namePlate.token = namePlateUnitToken
        namePlate.castBar = unitFrame.castBar
        namePlate.healthBar = unitFrame.healthBar
        ns.AddNamePlate(namePlateUnitToken, namePlate)
    end

    EventBus:TriggerEvent(name .. "_NAMEPLATE_CACHED", namePlate)
end

local function onNamePlateRemoved(_, unitToken)
    local namePlate = ns.GetNamePlate(unitToken)
    if not namePlate then return end

    if namePlate.RestoreColor then namePlate:RestoreColor() end
    namePlate.healthBar.label:SetText("")
    namePlate:ClearTicker()
    ns.namePlates[unitToken] = nil
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
                local unit = ns.namePlates[namePlate.namePlateUnitToken]
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
    elseif (key == "cVarClassColor") then
        toggleShowClassColorInNameplateCVar()
    elseif (key == "fontSize") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            local unit = ns.namePlates[namePlate.namePlateUnitToken]
            if unit and unit.healthBar.label then
                local fontName = unit.healthBar.label:GetFont()
                unit.healthBar.label:SetFont(tostring(fontName), settings.GetFontSize(), "OUTLINE")
            end
        end
    end
end

EventBus:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)
EventBus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)
EventBus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)