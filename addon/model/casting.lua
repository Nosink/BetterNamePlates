local name, ns = ...

local function getCastInfo(unitToken)
    local castName, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs =
        UnitCastingInfo(unitToken)

    if not castName then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs

    return castName, string.format("%.1f/%.1f", elapsed / 1000, duration / 1000)
end

local function hookCastBarEvents(nameplate)
    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnShow", function()
        nameplate.ticker = C_Timer.NewTicker(0.1, function()
            local castName, text = getCastInfo(nameplate.unitToken)
            ns.bus:TriggerEvent(name .. "_UPDATE_CAST_BAR", nameplate, castName, text)
        end)
    end)

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnHide", function()
        if nameplate.ticker then nameplate.ticker:Cancel() end
        ns.bus:TriggerEvent(name .. "_CLEAR_CAST_BAR", nameplate)
    end)
end

local function onNamePlateAdded(_, nameplate)
    hookCastBarEvents(nameplate)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_UNIT_ADDED", onNamePlateAdded)

local function onSettingsChanged(_, key)
    if (key == "displayCast") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            ns.bus:TriggerEvent(name .. "_UPDATE_CAST_BAR_SIZE", nameplate)
        end
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
