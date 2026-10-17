local name, ns = ...

local frame = {}
local nameLabel = {}
local timeLabel = {}

local function createFrame(castBarsContainer)
    frame = CreateFrame("Frame", nil, castBarsContainer)
    frame:SetPoint("TOPLEFT", castBarsContainer, "TOPLEFT", 0, 0)
    frame:SetPoint("BOTTOMRIGHT", castBarsContainer, "BOTTOMRIGHT", 0, 0)
    frame:SetClipsChildren(true)
end

local function createNameLabel(text)
    nameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameLabel:SetPoint("LEFT", frame, "LEFT", 5, 0)

    nameLabel:SetTextColor(1, 1, 1, 1)
    nameLabel:SetJustifyV("MIDDLE")
    nameLabel:SetJustifyH("LEFT")
    nameLabel:SetWordWrap(true)

    nameLabel.UpdateText = function(self, text)
        self:SetText(text)
    end
    nameLabel:UpdateText(text)
    nameLabel:Show()
end

local function createTimeLabel(text)
    timeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    timeLabel:SetPoint("RIGHT", frame, "RIGHT", -5, 0)

    timeLabel:SetTextColor(1, 1, 1, 1)
    timeLabel:SetJustifyV("MIDDLE")
    timeLabel:SetJustifyH("LEFT")
    timeLabel:SetWordWrap(true)

    timeLabel.UpdateText = function(self, text)
        self:SetText(text)
    end
    timeLabel:UpdateText(text)
    timeLabel:Show()
end


local function isNotValidNameplate(nameplate)
    return nameplate.CastLabelTime or nameplate.CastLabelName or not nameplate.UnitFrame.CastBarsContainer.castBar
end

local function initialize(nameplate, name, text)
    if isNotValidNameplate(nameplate) then return end

    createFrame(nameplate.UnitFrame.CastBarsContainer)
    createNameLabel(name)
    createTimeLabel(text)

    nameplate.CastLabelTime = timeLabel
    nameplate.CastLabelName = nameLabel
end


local function isNotInitialized(nameplate)
    return not nameplate.CastLabelTime or not nameplate.CastLabelName
end

local function onUpdateCastBar(_, nameplate, name, text)
    if isNotInitialized(nameplate) then
        initialize(nameplate, name, text)
    else
        nameplate.CastLabelName:UpdateText(name)
        nameplate.CastLabelTime:UpdateText(text)
    end
end

local function onClearCastBar(_, nameplate)
    onUpdateCastBar(_, nameplate, "", "")
end

ns.bus:RegisterEvent(name .. "_CLEAR_CAST_BAR", onClearCastBar)
ns.bus:RegisterEvent(name .. "_UPDATE_CAST_BAR", onUpdateCastBar)
