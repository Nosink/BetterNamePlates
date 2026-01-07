local name, ns = ...

local function onNamePlateHealthLabelUpdateRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit or not unit.label then return end

    unit.label:SetText(unit.text)
end

local function onNamePlateHealthLabelRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit or unit.label then return end

    local label = unit.healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("LEFT", unit.healthBar, "LEFT", 2, 0)
    local fontName = label:GetFont()
    label:SetFont(tostring(fontName), 10, "OUTLINE")
    label:SetTextColor(1, 1, 1, 1)
    label:SetText("")

    unit.label = label
end

ns:RegisterEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", onNamePlateHealthLabelUpdateRequest)
ns:RegisterEvent(name .. "_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)