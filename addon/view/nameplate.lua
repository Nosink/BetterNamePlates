local name, ns = ...


local function applyFontSize(nameplate)
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
    updateHealthText(nameplate)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_READY", onNamePlateReady)

local function onSettingsChanged(_, key)
    if (key == "fontSize") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            applyFontSize(nameplate)
        end
    end
    if (key == "healthFormat") then
        for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
            updateHealthText(nameplate)
        end
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
