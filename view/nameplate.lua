local name, ns = ...

local function onNamePlateColorUpdateRequest(_, unit)
    if not unit or not unit.healthBar or not unit.color then return end

    if not unit.RestoreColor then
        unit.RestoreColor = function (self)
            self.healthBar.barTexture:SetVertexColor(0, 0, 1)
        end
    end

    unit.healthBar.barTexture:SetVertexColor(unit.color.r, unit.color.g, unit.color.b)
end

ns:RegisterEvent(name .. "_COLOR_UPDATE_REQUEST", onNamePlateColorUpdateRequest)