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

local function setNameLabelPoints(label)
    label:ClearAllPoints()
    if ns.db.displayCast then
        label:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        label:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -frame:GetWidth() * 0.4, 0)
    else
        label:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        label:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    end
end

local function createNameLabel(text)
    nameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    setNameLabelPoints(nameLabel)

    nameLabel:SetTextColor(1, 1, 1, 1)
    nameLabel:SetJustifyV("MIDDLE")
    nameLabel:SetJustifyH("LEFT")
    nameLabel:SetWordWrap(true)

    nameLabel.UpdateText = function(self, text)
        if ns.db.displayCastName then
            self:SetText(text)
        else
            self:SetText("")
        end
    end
    nameLabel:UpdateText(text)
    nameLabel:Show()
end

local function createTimeLabel(text)
    timeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    local width = frame:GetWidth()
    timeLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    timeLabel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

    timeLabel:SetTextColor(1, 1, 1, 1)
    timeLabel:SetJustifyV("MIDDLE")
    timeLabel:SetJustifyH("RIGHT")
    timeLabel:SetWordWrap(true)

    timeLabel.UpdateText = function(self, text)
        if ns.db.displayCast then
            self:SetText(text)
        else
            self:SetText("")
        end
    end
    timeLabel:UpdateText(text)
    timeLabel:Show()
end


local function isNotValidNameplate(nameplate)
    local invalid = nameplate.CastLabelTime or nameplate.CastLabelName or
        not nameplate.UnitFrame or not nameplate.UnitFrame.CastBarsContainer.castBar
    return invalid
end

local function initialize(nameplate, name, text)
    if isNotValidNameplate(nameplate) then
        return
    end

    createFrame(nameplate.UnitFrame.CastBarsContainer.castBar)
    createNameLabel(name)
    createTimeLabel(text)

    nameplate.CastLabelTime = timeLabel
    nameplate.CastLabelName = nameLabel
end


local function isNotInitialized(nameplate)
    local notInitialized = not nameplate.CastLabelTime or not nameplate.CastLabelName
    return notInitialized
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
ns.bus:RegisterEvent(name .. "_UPDATE_CAST_BAR_SIZE", function(_, nameplate)
    if isNotInitialized(nameplate) then return end
    setNameLabelPoints(nameplate.CastLabelName)
end)
