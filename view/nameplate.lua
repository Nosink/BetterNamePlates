local name, ns = ...

local function onNamePlateColorUpdateRequest(_, namePlateUnitToken)
    if not ns.units[namePlateUnitToken] or not ns.units[namePlateUnitToken].healthBar or not ns.units[namePlateUnitToken].color then return end

    ns.units[namePlateUnitToken].healthBar.barTexture:SetVertexColor(ns.units[namePlateUnitToken].color.r, ns.units[namePlateUnitToken].color.g, ns.units[namePlateUnitToken].color.b, 1)
end

ns:RegisterEvent(name .. "_NAMEPLATE_COLOR_UPDATE_REQUEST", onNamePlateColorUpdateRequest)