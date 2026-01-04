local name, ns = ...

local function onNamePlateData(_, healthBar, namePlateUnitToken)
    ns.units[namePlateUnitToken] = ns.units[namePlateUnitToken] or {}
    if not ns.units[namePlateUnitToken].label then
        local label = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("LEFT", healthBar, "LEFT", 2, 0)
        local fontName = label:GetFont()
        label:SetFont(tostring(fontName), 10, "OUTLINE")
        label:SetTextColor(1, 1, 1, 1)
        label:SetText("")
        ns.units[namePlateUnitToken].label = label
    end
    ns:TriggerEvent(name .. "_NAMEPLATE_HEALTH_LABEL_READY", namePlateUnitToken)
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)