local name, ns = ...

local function onHealthLabelUpdateRequest(_, unitToken, text)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local healthLabel = namePlate.UnitFrame.healthLabel

    healthLabel:SetText(text)
end


BNPBus:RegisterEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", onHealthLabelUpdateRequest)