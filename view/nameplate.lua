local name, ns = ...

local function onNamePlateColorUpdateRequest(_, namePlateUnitToken)
    local unit = ns.units[namePlateUnitToken]
    if not unit or not unit.healthBar or not unit.color then return end

    unit.healthBar.barTexture:SetVertexColor(unit.color.r, unit.color.g, unit.color.b, 1)
end

ns:RegisterEvent(name .. "_COLOR_UPDATE_REQUEST", onNamePlateColorUpdateRequest)