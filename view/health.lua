local name, ns = ...

local settings = ns.settings

local function onNamePlateHealthLabelUpdateRequest(_, unit)
    if not unit or not unit.healthBar.label then return end

    if settings.IsHealthDisplayEnabled() then
        unit.healthBar.label:SetText(unit.text)
    else
        unit.healthBar.label:SetText("")
    end
end

local function onNamePlateHealthLabelRequest(_, unit)
    if not unit or unit.healthBar.label or not unit.healthBar then return end

    unit.healthBar.label = unit.healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    unit.healthBar.label:SetPoint("LEFT", unit.healthBar, "LEFT", 2, 0)
    unit.healthBar.label:SetJustifyV("MIDDLE")
    local fontName = unit.healthBar.label:GetFont()
    unit.healthBar.label:SetFont(tostring(fontName), settings.GetFontSize(), "OUTLINE")
    unit.healthBar.label:SetTextColor(1, 1, 1, 1)
    unit.healthBar.label:SetText("")
    unit.healthBar.label:Show()

end

ns:RegisterEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", onNamePlateHealthLabelUpdateRequest)
ns:RegisterEvent(name .. "_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)