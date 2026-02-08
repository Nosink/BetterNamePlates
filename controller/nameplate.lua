local name, ns = ...

local function onNamePlateAdded(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
end

local function onNamePlateRemoved(_, unitToken)
    BNPBus:TriggerEvent(name .. "_NAME_PLATE_REMOVED", unitToken)
end

local function onNamePlateReady(_, unitToken)
    local friendly = UnitIsFriend("player", unitToken)
    if not friendly then return end

    local guid = UnitGUID(unitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local className = UnitClassBase(unitToken)
    namePlate.color = C_ClassColor.GetClassColor(className)

    BNPBus:TriggerEvent(name .. "_NAME_PLATE_UPDATE_COLOR_REQUEST", unitToken)
end

local function onUnitHealth(_, unitToken)
   onNamePlateReady(nil, unitToken)
end

BNPBus:RegisterEvent("UNIT_HEALTH", onUnitHealth)

BNPBus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
BNPBus:RegisterEvent("NAME_PLATE_UNIT_REMOVED", onNamePlateRemoved)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)