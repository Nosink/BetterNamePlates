local name, ns = ...

local function createCastLabel(UnitFrame, castBar)
    if not castBar then return end

    local castLabel = castBar:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    castLabel:SetPoint("RIGHT", castBar, "RIGHT", -1, 0)
    local fontName = castLabel:GetFont()
    castLabel:SetFont(tostring(fontName), 10, "OUTLINE")
    castLabel:SetJustifyV("MIDDLE")
    castLabel:SetJustifyH("RIGHT")
    castLabel:SetTextColor(1, 1, 1, 1)
    castLabel:Show()

    UnitFrame.castLabel = castLabel
end

local function onNamePlateReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local UnitFrame = namePlate.UnitFrame or nil
    if not UnitFrame then return end

    if not UnitFrame.castLabel then
        createCastLabel(UnitFrame, UnitFrame.castBar)
    end

    BNPBus:TriggerEvent(name .. "_NAME_PLATE_CAST_LABEL_READY", unitToken)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)