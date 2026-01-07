local name, ns = ...

local function onNamePlateHealthUpdate(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit or not unit.label then return end

    unit.label:SetText(unit.text)
end

local function onNamePlateHealthLabelRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit or unit.label then return end

    local label = unit.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("LEFT", unit.frame, "LEFT", 2, 0)
    local fontName = label:GetFont()
    label:SetFont(tostring(fontName), 10, "OUTLINE")
    label:SetTextColor(1, 1, 1, 1)
    label:SetText("")
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", onNamePlateHealthUpdate)
ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)