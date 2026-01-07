local name, ns = ...

local data = ns.data

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

local function onNamePlateRemoved(_)
    for i=data.minNameplates, data.maxNameplates do
        local namePlateUnitToken = "nameplate" .. tostring(i)

        local unit = ns.units[namePlateUnitToken]
        if not unit then break end

        local label = unit.label
        if not label then break end

        label:SetText("")
    end
end

ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_UPDATE", onNamePlateHealthUpdate)
ns:RegisterEvent(name .. "_NAMEPLATE_HEALTH_LABEL_REQUEST", onNamePlateHealthLabelRequest)
-- ns:HookSecureFunc(NamePlateBaseMixin, "OnRemove", onNamePlateRemoved)