local name, ns = ...


local alpha = 1.0

local function onNamePlateUpdateColorRequest(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local color = namePlate.color
    local barTexture = namePlate.UnitFrame.healthBar.barTexture

    barTexture:SetVertexColor(color.r, color.g, color.b, alpha)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_UPDATE_COLOR_REQUEST", onNamePlateUpdateColorRequest)