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

local function onCastBarShow(unitToken)
    print ("Cast bar shown for " .. unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    clearTicker(namePlate)

    local ticker = C_Timer.NewTicker(0.1, function() 
        local text = getCastInfo(unitToken)
        BNPBus:TriggerEvent(name .. "_CAST_LABEL_UPDATE_REQUEST", unitToken, text)
    end, nil)

    namePlate.castBarTicker = ticker
end

local function onCastBarHide(unitToken)
    print ("Cast bar hidden for " .. unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    clearTicker(namePlate)
end

local function onCastLabelReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local castLabel = namePlate.UnitFrame.castLabel
    BNPBus:HookScript(castLabel, "OnShow", function() onCastBarShow(unitToken) end)
    BNPBus:HookScript(castLabel, "OnHide", function() onCastBarHide(unitToken) end)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_CAST_LABEL_READY", onCastLabelReady)