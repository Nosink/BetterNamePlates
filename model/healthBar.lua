local name, ns = ...

local settings = ns.settings

local function createHealthLabel(UnitFrame, healthBar)
    if not healthBar  then return end

    local healthLabel = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthLabel:SetPoint("LEFT", healthBar, "LEFT", 1, 0)
    healthLabel:SetJustifyV("MIDDLE")
    local fontName = healthLabel:GetFont()
    healthLabel:SetFont(tostring(fontName), settings.GetFontSize(), "OUTLINE")
    healthLabel:SetTextColor(1, 1, 1, 1)
    healthLabel:SetText("")
    healthLabel:Show()

    UnitFrame.healthLabel = healthLabel
end

local function onNamePlateReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local UnitFrame = namePlate.UnitFrame or nil
    if not UnitFrame then return end

    if not UnitFrame.healthLabel then 
        createHealthLabel(UnitFrame, UnitFrame.healthBar)
    end

    BNPBus:TriggerEvent(name .. "_NAME_PLATE_HEALTH_LABEL_READY", unitToken)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)