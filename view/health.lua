local name, ns = ...

local function onNamePlateHealthUpdate(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit then return end

    local label = unit.label
    if not label then return end

    label:SetText(unit.text or "")
end

local function onNamePlateHealthLabelRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit.label then
        local label = unit.healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("LEFT", unit.healthBar, "LEFT", 2, 0)
        local fontName = label:GetFont()
        label:SetFont(tostring(fontName), 10, "OUTLINE")
        label:SetTextColor(1, 1, 1, 1)
        label:SetText("")
        ns.units[namePlateUnitToken].label = label
    end
    ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_READY", namePlateUnitToken)
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", onNamePlateHealthUpdate)
ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)