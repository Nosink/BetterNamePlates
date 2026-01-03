local name, ns = ...

local function onNamePlateUpdateRequest(_, healthBar, color)
    healthBar.barTexture:SetVertexColor(color.r, color.g, color.b, 1)
end

ns:RegisterEvent(name .. "_NAMEPLATE_UPDATE_REQUEST", onNamePlateUpdateRequest)