local name, ns = ...

local function getCastInfo(unitToken)
    local name, _, _, startTimeMs, endTimeMs = UnitCastingInfo(unitToken)
    if not name then
        name, _, _, startTimeMs, endTimeMs = UnitChannelInfo(unitToken)
    end

    if not name then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs

    return string.format("%.1f/%.1f", elapsed / 1000, duration / 1000)
end

local function clearTicker(namePlate)
    if namePlate.castBarTicker then
        namePlate.castBarTicker:Cancel()
        namePlate.castBarTicker = nil
    end
end

local function onCastBarShow(UnitFrame)
    local namePlate = ns:GetNamePlate(UnitFrame.unitToken)
    if not namePlate then return end

    clearTicker(namePlate)

    local ticker = C_Timer.NewTicker(0.1, function() 
        local text = getCastInfo(UnitFrame.unitToken)
        BNPBus:TriggerEvent(name .. "_CAST_LABEL_UPDATE_REQUEST", UnitFrame.unitToken, text)
    end, nil)

    namePlate.castBarTicker = ticker
end

local function onNamePlateAdded(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    onCastBarShow(namePlate.UnitFrame)
end

local function onNamePlateRemoved(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    clearTicker(namePlate)
end

local function onNamePlateReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local UnitFrame = namePlate.UnitFrame
    local castBar = namePlate.UnitFrame.castBar

    BNPBus:HookScript(castBar, "OnShow", function() onCastBarShow(UnitFrame) end)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_ADDED", onNamePlateAdded)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_REMOVED", onNamePlateRemoved)
BNPBus:RegisterEvent(name .. "_NAME_PLATE_CAST_LABEL_READY", onNamePlateReady)