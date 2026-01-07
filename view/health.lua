local name, ns = ...

local function onNamePlateHealthLabelUpdateRequest(_, namePlateUnitToken)
    if not ns.units[namePlateUnitToken] or not ns.units[namePlateUnitToken].label then return end

    ns.units[namePlateUnitToken].label:SetText(ns.units[namePlateUnitToken].text)
end

local function onNamePlateHealthLabelRequest(_, namePlateUnitToken)
    if not ns.units[namePlateUnitToken] or ns.units[namePlateUnitToken].label then return end

    local label = ns.units[namePlateUnitToken].frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("LEFT", ns.units[namePlateUnitToken].frame, "LEFT", 2, 0)
    local fontName = label:GetFont()
    label:SetFont(tostring(fontName), 10, "OUTLINE")
    label:SetTextColor(1, 1, 1, 1)
    label:SetText("")
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_UPDATE_REQUEST", onNamePlateHealthLabelUpdateRequest)
ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)