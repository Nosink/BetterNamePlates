local name, ns = ...

local function getCastInfo(unitToken)
    local name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs =
        UnitCastingInfo(unitToken)

    if not name then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs

    return name, string.format("%.1f/%.1f", elapsed / 1000, duration / 1000)
end

local function hookCastBarEvents(nameplate)
    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnShow", function()
        nameplate.ticker = C_Timer.NewTicker(0.1, function()
            local name, text = getCastInfo(nameplate.unitToken)
            ns.bus:TriggerEvent(name .. "_UPDATE_CAST_BAR", nameplate, name, text)
        end)
    end)

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnHide", function()
        if nameplate.ticker then nameplate.ticker:Cancel() end
    end)
end


local function onNamePlateAdded(_, nameplate)
    hookCastBarEvents(nameplate)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
