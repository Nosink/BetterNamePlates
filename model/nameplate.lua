local name, ns = ...

local settings = ns.settings

local function onNamePlateCreated(_, namePlateFrame)
    
    local namePlate = {}
    namePlate.frame = namePlateFrame
    namePlate.castBar = namePlateFrame.castBar
    namePlate.healthBar = namePlateFrame.healthBar

    ns:AddNamePlate(namePlate)
end

local function onNamePlateAdded(_, unitToken)
    local unitFramme = driverFrame.UnitFrame
    if not unitFramme then return end

    local unit = {}
    unit.token = namePlateUnitToken
    unit.frame = unitFramme
    unit.healthBar = unitFramme.healthBar

    ns.activePlates[namePlateUnitToken] = unit

    ns:TriggerEvent(name .. "_NAMEPLATE_CACHED", unit)
end

local function onNamePlateRemoved(_, unitToken)
    local unit = ns.activePlates[unitToken]
    if not unit then return end

    if unit.RestoreColor then unit:RestoreColor() end
    unit.healthBar.label:SetText("")
    unit:ClearTicker()
    ns.activePlates[unitToken] = nil
end

local function toggleShowClassColorInNameplateCVar()
    local state = settings.IsUsingCVarsEnabled() and 1 or 0
    --SetCVar("ShowClassColorInFriendlyNameplate", state)

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
    elseif (key == "cVarClassColor") then
        toggleShowClassColorInNameplateCVar()
    elseif (key == "fontSize") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            local unit = ns.activePlates[namePlate.namePlateUnitToken]
            if unit and unit.healthBar.label then
                local fontName = unit.healthBar.label:GetFont()
                unit.healthBar.label:SetFont(tostring(fontName), settings.GetFontSize(), "OUTLINE")
            end
        end
    end
end

ns:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)
ns:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
ns:RegisterEvent("NAME_PLATE_CREATED", onNamePlateCreated)

ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)