local name, ns = ...

local label = {}
local editBox = {}

local function createLabel(section, text, params)
    local fontString = params and params.fontString or
        ns.builder.fontString(nil, "ARTWORK", "GameFontNormal")
    local offset = params and params.offset or
        ns.builder.offset(0, -10)
    local point = params and params.textPoint or
        ns.builder.point("TOPLEFT", section.anchor, "BOTTOMLEFT", offset.x, offset.y)

    label = section.optionsPanel:CreateFontString(fontString.name, fontString.layer, fontString.template)
    label:SetPoint(point.point, point.relativeTo, point.relativePoint, point.x, point.y)
end

local function setText(text, params)
    local color = params and params.color or
        ns.builder.color(1, 1, 1, 1)
    local justifyH = params and params.justify and params.justify.h or
        "LEFT"
    local justifyV = params and params.justify and params.justify.v or
        "TOP"

    local filename, fontHeight, flags = label:GetFont()
    filename = params and params.font or
        filename
    fontHeight = params and params.fontHeight or
        fontHeight
    flags = params and params.flags or
        flags

    label:SetFont(tostring(filename), fontHeight, flags)
    label:SetTextColor(color.r, color.g, color.b, color.a)
    label:SetJustifyH(justifyH)
    label:SetJustifyV(justifyV)
    label:SetText(text)
end

local function createEditBox(section, key, params)
    local point = params and params.controlPoint or
        ns.builder.point("LEFT", label, "RIGHT", 10, 0)

    editBox = CreateFrame("EditBox", nil, section.optionsPanel, "InputBoxTemplate")
    editBox:SetPoint(point.point, point.relativeTo, point.relativePoint, point.x, point.y)
end

local function setSize(params)
    local width = params and params.width or
        45
    local height = params and params.height or
        22
    local justifyH = params and params.justify and params.justify.h or
        "CENTER"
    local justifyV = params and params.justify and params.justify.v or
        "MIDDLE"

    editBox:SetAutoFocus(false)
    editBox:SetJustifyH(justifyH)
    editBox:SetJustifyV(justifyV)
    editBox:SetSize(width, height)
end

local function setValidator(params)
    local validator = params and params.validator or
        ns.builder.noValidator()

    editBox.validator = validator
end

local function setEvents(key)
    ns.bus:HookScript(editBox, "OnShow", function(self)
        self:SetCursorPosition(0)
    end)

    editBox:SetScript("OnEditFocusLost", function(self)
        local text = self:GetText()
        if not self.validator.validate(text) then
            text = self.validator.normalize(text)
            self:SetText(text)
        end
        ns.db[key] = text
        ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", key)
    end)

    editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
end

local function setFetch(key)
    editBox.Fetch = function(self)
        local value = ns.db and ns.db[key]
        self:SetText(tostring(value))
    end
end

function ns.builder.CreateEditBox(section, text, key, params)
    createLabel(section, text, params)
    setText(text, params)

    createEditBox(section, key, params)
    setSize(params)
    setValidator(params)
    setEvents(key)
    setFetch(key)

    section:setAnchor(label)
    return editBox
end
