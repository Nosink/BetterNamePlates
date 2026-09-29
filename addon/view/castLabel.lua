local name, ns = ...

local function onCastLabelUpdateRequest(_, unitToken, text)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local castLabel = namePlate.UnitFrame.castLabel

    castLabel:SetText(text)
end


ns.bus:RegisterEvent(name .. "_CAST_LABEL_UPDATE_REQUEST", onCastLabelUpdateRequest)
