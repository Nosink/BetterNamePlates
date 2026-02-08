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

local function onCastBarShown(unitToken)
    C_Timer.NewTicker(0.1, function() 
        local text = getCastInfo(unitToken)
        BNPBus:TriggerEvent(name .. "_CAST_LABEL_UPDATE_REQUEST", unitToken, text)
    end, nil)
end

local function onCastLabelReady(_, unitToken)
    local namePlate = ns:GetNamePlate(unitToken)
    local castLabel = namePlate.UnitFrame.castLabel
    onCastBarShown(unitToken)
    --BNPBus:HookScript(castLabel, "OnShow", function() onCastBarShown(unitToken) end)
end

BNPBus:RegisterEvent(name .. "_NAME_PLATE_CAST_LABEL_READY", onCastLabelReady)