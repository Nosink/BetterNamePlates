local name, ns = ...

function ns.builder.CreateText(self, text)
    local label = self.optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT", self.anchor, "BOTTOMLEFT", 0, -4)
    local font, _, flags = label:GetFont()
    label:SetFont(tostring(font), 12, flags)
    label:SetTextColor(1, 1, 1, 1)
    label:SetJustifyH("LEFT")
    label:SetText(" " .. text)

    self.anchor = label
    return label
end