local name, ns = ...

local editBox = {}

local function createEditBox(section, settings)
    editBox = CreateFrame("EditBox", nil, section.optionsPanel, "InputBoxTemplate")
    editBox:SetPoint(settings.point.point, settings.point.relativeTo, settings.point.relativePoint, settings.point.x,
        settings.point.y)
end

local function setNumeric(settings)
    editBox:SetNumeric(settings.isNumeric)
    if (settings.allowDecimals and settings.isNumeric) then
        editBox:SetNumericFullRange(settings.isNumeric)
    end
end

local function setSize(settings)
    editBox:SetAutoFocus(false)
    editBox:SetJustifyH(settings.justify.h)
    editBox:SetSize(settings.width, settings.height)
end

local function setValidator(settings)
    editBox.validator = settings.validator
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

function ns.builder.CreateEditBox(section, text, key, settings)
    --
    local _, label = ns.builder.CreateText(section, text, settings.textSettings)
    settings:SetLabel(label)

    createEditBox(section, settings)
    setNumeric(settings)
    setSize(settings)
    setValidator(settings)
    setEvents(key)
    setFetch(key)

    return label, editBox
end
