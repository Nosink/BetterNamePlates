local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

local function onNamePlateAdded(_, unitToken)
    bus:TriggerEvent(name .. "_NAME_PLATE_ADDED", unitToken)
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

    bus:TriggerEvent(name .. "_NAME_PLATE_UPDATE_COLOR_REQUEST", unitToken)
end

bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
bus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)