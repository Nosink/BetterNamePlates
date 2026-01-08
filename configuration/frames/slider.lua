local name, ns = ...

function ns.builder.CreateSlider(self, text, key, min, max, step)
    local slider = CreateFrame("Slider", name .. "Options" .. key .. "SL", self.optionsPanel, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", self.anchor, "BOTTOMLEFT", 25, -30)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    slider:SetValue(ns.database[key] or 0)

    local sText = _G[slider:GetName() .. "Text"]
    if sText then sText:SetText(text) end
    local low = _G[slider:GetName() .. "Low"]
    local high = _G[slider:GetName() .. "High"]
    if low then low:SetText(tostring(min)) end
    if high then high:SetText(tostring(max)) end

    local valueText = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    valueText:SetPoint("RIGHT", slider, "RIGHT", 40, 0)
    valueText:SetText(string.format("%.2f", ns.database[key] or tonumber(min)))

    local function updateValueLabel(v)
        valueText:SetText(string.format("%.2f", v or slider:GetValue()))
    end

    slider:SetScript("OnValueChanged", function(self, value)
        ns.database[key] = value
        updateValueLabel(value)
        ns:TriggerEvent(name .. "_SETTINGS_CHANGED", key)
    end)

    slider.FetchFromDB = function(self)
        self:SetValue(ns.database[key] or 0)
        updateValueLabel(ns.database[key] or 0)
    end

    self.anchor = slider
    return slider
end