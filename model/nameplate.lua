local _, ns = ...

local settings = ns.settings

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    if true then return end
    local unitFrame = driverFrame:GetNamePlateForUnit(namePlateUnitToken)
    if not unitFrame then return end

    local unit = unitFrame.unitFrame.unit
    if not unit then return end

    if settings.IsClassColorEnabled() then
        local _, class = UnitClass(unit)
        if class then
            local color = RAID_CLASS_COLORS[class]
            if color then
                unitFrame.healthBar:SetStatusBarColor(color.r, color.g, color.b)
            end
        end
    end
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)