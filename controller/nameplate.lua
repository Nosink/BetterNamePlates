local name, ns = ...

local function onNamePlateAdded(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
end

local function onNamePlateReady(_, unitToken)
    local friendly = UnitIsFriend("player", unitToken)
    if not friendly then return end

    local guid = UnitGUID(unitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local namePlate = ns:GetNamePlate(unitToken)
    local className = UnitClassBase(unitToken)
    namePlate.color = C_ClassColor.GetClassColor(className)

    BNPBus:TriggerEvent(name .. "_NAME_PLATE_UPDATE_COLOR_REQUEST", unitToken)
end

BNPBus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)