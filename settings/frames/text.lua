local _, ns = ...

local label = {}

local function createFontString(section, params)
    local fontString = params and params.fontString or
        ns.builder.fontString(nil, "ARTWORK", "GameFontNormal")
    local offset = params and params.offset or
        ns.builder.offset(0, 0)
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

local function setWidth(params)
    local width = params and params.width or
        label:GetStringWidth()

    label:SetWidth(width)
end

function ns.builder.CreateText(section, text, params)
    createFontString(section, params)

    setText(text, params)
    setWidth(params)

    section:setAnchor(label)
    return label
end
