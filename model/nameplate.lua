local name, ns = ...

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local guid = UnitGUID(namePlateUnitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local healthBar = driverFrame.UnitFrame.healthBar
    local classFilename = UnitClassBase(namePlateUnitToken)

    ns:TriggerEvent(name .. "_NAMEPLATE_DATA", healthBar, classFilename)
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)