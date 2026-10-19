local name, ns = ...

local function getCastInfo(unitToken)
    local name, _, _, startTimeMs, endTimeMs = UnitCastingInfo(unitToken)
    if not name then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs
    local timeText = string.format("%.1f/%.1f", elapsed / 1000, duration / 1000);

    return ns.db.displayCastName and name or "", ns.db.displayCast and timeText or ""
end

local function hookCastBarEvents(nameplate)
    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnShow", function()
        nameplate.ticker = C_Timer.NewTicker(0.1, function()
            local castName, timeText = getCastInfo(nameplate.unitToken)
            ns.bus:TriggerEvent(name .. "_UPDATE_CAST_BAR", nameplate, castName, timeText)
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
