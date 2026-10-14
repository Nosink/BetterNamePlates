local name, ns = ...

local function updateFontSize(nameplate)
    local healthLabel = nameplate.UnitFrame.HealthLabel
    if not healthLabel then return end

    healthLabel:UpdateFontSize()
end

local function updateHealthText(nameplate)
    local healthLabel = nameplate.UnitFrame.HealthLabel
    if not healthLabel then return end

    healthLabel:UpdateText()
end

local function onNamePlateReady(_, nameplate)
    updateFontSize(nameplate)
    updateHealthText(nameplate)
end

local function onUpdateHealthRequested(_, nameplate)
    updateHealthText(nameplate)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)
ns.bus:RegisterEvent(name .. "_UPDATE_HEALTH", onUpdateHealthRequested)

local function onSettingsChanged(_, key)
    if (key == "fontSize") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            updateFontSize(nameplate)
        end
    end
    if (key == "healthFormat" or key == "displayOnNPCS" or key == "displayOnPlayers" or key == "displayHealth") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            updateHealthText(nameplate)
        end
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
