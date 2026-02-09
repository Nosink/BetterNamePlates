local name, ns = ...

local settings = ns.settings

local function applyFontSize(namePlate)
    local healthLabel = namePlate.UnitFrame.healthLabel
    if not healthLabel then return end

    local fontSize = settings.GetFontSize()
    local fontName, _, fontFlags = healthLabel:GetFont()

    healthLabel:SetFont(fontName, fontSize, fontFlags)
end

local function onHealthLabelUpdateRequest(_, unitToken, text)
    local namePlate = ns:GetNamePlate(unitToken)
    if not namePlate then return end

    local healthLabel = namePlate.UnitFrame.healthLabel

    healthLabel:SetText(text)
end

local function onSettingsChanged(_, key)
    if (key == "fontSize") then
        for _, namePlate in pairs(ns:GetAllNameplates()) do
            local unitToken = namePlate.UnitFrame.unitToken
            if not unitToken then return end
            applyFontSize(namePlate)
        end
    end
end

BNPBus:RegisterEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", onHealthLabelUpdateRequest)
BNPBus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)