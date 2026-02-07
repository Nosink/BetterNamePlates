local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

local settings = ns.settings

local function createCastLabel(UnitFrame, castBar)
    if not castBar then return end

    local castLabel = castBar:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    castLabel:SetPoint("CENTER", castBar, "CENTER", 0, 0)
    UnitFrame.castLabel = castLabel
end

local function onNamePlateAdded(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local UnitFrame = namePlate.UnitFrame or nil
    if not UnitFrame then return end

    if not UnitFrame.healthLabel then 
        createHealthLabel(UnitFrame, UnitFrame.healthBar)
    end

    if not UnitFrame.castLabel then
        createCastLabel(UnitFrame, UnitFrame.castBar)
    end

    bus:TriggerEvent(name .. "_NAME_PLATE_READY", unitToken)
end

local function onNamePlateRemoved(_, unitToken)
    -- local namePlate = ns:GetNamePlate(unitToken)
    -- if not namePlate then return end
-- 
    -- if namePlate.RestoreColor then namePlate:RestoreColor() end
    -- namePlate.healthBar.label:SetText("")
    -- namePlate:ClearTicker()
    -- ns.namePlates[unitToken] = nil
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

local function onForbidenNamePlateCreated(_, namePlateFrame)
    print("Forbidden nameplate created")
    for k, v in pairs(namePlateFrame) do
        print(k .. ": " .. tostring(v))
    end

end
-- bus:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)

bus:RegisterEvent(name .. "_NAME_PLATE_ADDED", onNamePlateAdded)
bus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)

bus:RegisterEvent("FORBIDDEN_NAME_PLATE_CREATED", onForbidenNamePlateCreated)
-- bus:RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
-- bus:RegisterEvent("FORBIDDEN_NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)

bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)