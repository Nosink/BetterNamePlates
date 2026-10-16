local name, ns = ...

local function getCastInfo(unitToken)
    local name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs =
        UnitCastingInfo(unitToken)

    if not name then return "" end

    local currentTime = GetTime() * 1000
    local duration = endTimeMs - startTimeMs
    local elapsed = currentTime - startTimeMs

    return string.format("%.1f/%.1f", elapsed / 1000, duration / 1000)
end

local function getCastInfoName(unitToken)
    local name, displayName, textureID, startTimeMs, endTimeMs, isTradeskill, castID, notInterruptible, castingSpellID, castBarID, delayTimeMs =
        UnitCastingInfo(unitToken)

    if not name then return "" end

    return name
end

local function createCastLabelTime(nameplate)
    if nameplate.UnitFrame.CastLabelTime then return end

    local castBar = nameplate.UnitFrame.CastBarsContainer.castBar
    if not castBar then return end

    local labelFrame = CreateFrame("Frame", nil, nameplate.UnitFrame.CastBarsContainer)
    labelFrame:SetAllPoints(castBar)
    labelFrame:SetFrameStrata("HIGH")
    local width, height = castBar:GetSize()

    local castLabelName = labelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    castLabelName:SetPoint("LEFT", castBar, "LEFT", 5, 0)

    local file, _, flags = castLabelName:GetFont()
    castLabelName:SetFont(tostring(file), 10, flags)

    castLabelName:SetJustifyV("MIDDLE")
    castLabelName:SetJustifyH("LEFT")
    castLabelName:SetTextColor(1, 1, 1, 1)

    castLabelName.UpdateText = function(self)
        local text = getCastInfoName(nameplate.unitToken)
        self:SetText(text)
    end

    castLabelName:SetText("")
    castLabelName:Hide()



    local castLabelTime = labelFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    castLabelTime:SetPoint("RIGHT", castBar, "RIGHT", -5, 0)

    local file, _, flags = castLabelTime:GetFont()
    castLabelTime:SetFont(tostring(file), 10, flags)

    castLabelTime:SetJustifyV("MIDDLE")
    castLabelTime:SetJustifyH("RIGHT")
    castLabelTime:SetTextColor(1, 1, 1, 1)

    castLabelTime.UpdateText = function(self)
        self.timer = C_Timer.NewTicker(0.05, function()
            local text = getCastInfo(nameplate.unitToken)
            self:SetText(text)
        end)
    end

    castLabelTime.ClearTimer = function(self)
        self:SetText("")
        self.timer = self.timer and self.timer:Cancel() or nil
    end

    castLabelTime:SetText("")
    castLabelTime:Hide()


    nameplate.UnitFrame.CastLabelTime = castLabelTime
    nameplate.UnitFrame.CastLabelName = castLabelName

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnShow", function()
        if ns.db.displayCast then
            nameplate.UnitFrame.CastLabelTime:UpdateText()
            nameplate.UnitFrame.CastLabelTime:Show()
        end
        if ns.db.displayCastName then
            nameplate.UnitFrame.CastLabelName:UpdateText()
            nameplate.UnitFrame.CastLabelName:Show()
        end
    end)

    ns.bus:HookScript(nameplate.UnitFrame.CastBarsContainer.castBar, "OnHide", function()
        nameplate.UnitFrame.CastLabelTime:ClearTimer()
        nameplate.UnitFrame.CastLabelTime:Hide()
        nameplate.UnitFrame.CastLabelName:Hide()
    end)
end


local function onNamePlateUnitAdded(_, nameplate)
    createCastLabelTime(nameplate)
end

ns.bus:RegisterEvent(name .. "_NAME_PLATE_UNIT_ADDED", onNamePlateUnitAdded)
