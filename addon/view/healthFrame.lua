local name, ns = ...

local enums = ns.enums

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

local function updateShamanHealthBarColor(nameplate)
    if ns.expansion > enums.expansion.CLASSIC or not ns.db.coloredNameplates or not ns.db.shamanColor then return end

    local _, _, classId = UnitClass(nameplate.unitToken)
    if classId ~= enums.classID.SHAMAN then return end

    local r, g, b = nameplate.UnitFrame.healthBar:GetStatusBarColor()
    if r == 0.00 and g == 0.44 and b == 0.87 then return end

    nameplate.UnitFrame.healthBar:SetStatusBarColor(0.00, 0.44, 0.87)
end

local function hookStatusBarSetColor(nameplate)
    if ns.expansion > enums.expansion.CLASSIC then return end

    hooksecurefunc(nameplate.UnitFrame.healthBar, "SetStatusBarColor",
        function(self)
            local nameplate = self:GetParent():GetParent():GetParent()
            updateShamanHealthBarColor(nameplate)
        end)
end

local function updateHealthLabel(nameplate, text)
    nameplate.HealthLabel:UpdateText(text)
end

local function isNotValidNameplate(nameplate)
    return nameplate.HealthLabel or not nameplate.UnitFrame.healthBar
end

local function initialize(nameplate, text)
    if isNotValidNameplate(nameplate) then return end

    createFrame(nameplate.UnitFrame.healthBar)
    createLabel(text)

    hookStatusBarSetColor(nameplate)

    nameplate.HealthLabel = label
end

local function isNotInitialized(nameplate)
    return not nameplate.HealthLabel
end

local function onUnitHealthChanged(_, nameplate, text)
    if isNotInitialized(nameplate) then
        initialize(nameplate, text)
    else
        updateHealthLabel(nameplate, text)
        updateShamanHealthBarColor(nameplate)
    end
end

local function onNamePlateHealthSizeChanged(_, nameplate)
    if isNotInitialized(nameplate) then return end

    nameplate.HealthLabel:UpdateFontSize()
end

ns.bus:RegisterEvent(name .. "_UPDATE_NAMEPLATE_HEALTH", onUnitHealthChanged)
ns.bus:RegisterEvent(name .. "_UPDATE_NAMEPLATE_HEALTH_SIZE", onNamePlateHealthSizeChanged)
