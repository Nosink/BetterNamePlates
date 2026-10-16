local name, ns = ...

local frame = {}
local label = {}

local function createFrame(healthBar)
    frame = CreateFrame("Frame", nil, healthBar)
    frame:SetPoint("TOPLEFT", healthBar, "TOPLEFT", 0, 0)
    frame:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", 0, 0)
    frame:SetClipsChildren(true)
end

local function createLabel(text)
    label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalOutline")
    label:SetPoint("LEFT", frame, "LEFT", 1, 0)

    label:SetTextColor(1, 1, 1, 1)
    label:SetJustifyV("MIDDLE")
    label:SetJustifyH("LEFT")
    label:SetWordWrap(true)

    label.UpdateFontSize = function(self)
        local file, _, flags = self:GetFont()
        self:SetFont(tostring(file), tonumber(ns.db.fontSize), flags)
    end
    label:UpdateFontSize()

    label.UpdateText = function(self, text)
        self:SetText(text)
        self:Show();
    end
    label:UpdateText(text)
end

local function isNotValidNameplate(nameplate)
    return nameplate.HealthLabel or not nameplate.UnitFrame.healthBar
end

local function initialize(nameplate, text)
    if isNotValidNameplate(nameplate) then return end

    createFrame(nameplate.UnitFrame.healthBar)
    createLabel(text)

    nameplate.HealthLabel = label
end

local function isNotInitialized(nameplate)
    return not nameplate.HealthLabel
end

local function onUnitHealthChanged(_, nameplate, text)
    if isNotInitialized(nameplate) then
        initialize(nameplate, text)
    else
        nameplate.HealthLabel:UpdateText(text)
    end
end

local function onNamePlateHealthSizeChanged(_, nameplate)
    if isNotInitialized(nameplate) then return end

    nameplate.HealthLabel:UpdateFontSize()
end

ns.bus:RegisterEvent(name .. "_UPDATE_NAMEPLATE_HEALTH", onUnitHealthChanged)
ns.bus:RegisterEvent(name .. "_UPDATE_NAMEPLATE_HEALTH_SIZE", onNamePlateHealthSizeChanged)
