local name, ns = ...

local function createHealthLabel(nameplate)
    if nameplate.UnitFrame.HealthLabel then return end

    local healthBar = nameplate.UnitFrame.healthBar
    if not healthBar then return end

    local healthLabel = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalOutline")
    healthLabel:SetPoint("LEFT", healthBar, "LEFT", 2, 0)

    healthLabel.UpdateFontSize = function(self)
        local file, _, flags = self:GetFont()
        self:SetFont(tostring(file), tonumber(ns.db.fontSize), flags)
    end

    healthLabel:UpdateFontSize()

    healthLabel:SetJustifyV("MIDDLE")
    healthLabel:SetJustifyH("LEFT")
    healthLabel:SetTextColor(1, 1, 1, 1)

    healthLabel.UpdateText = function(self, text)
        self:SetText(text)
        self:Show();
    end

    nameplate.UnitFrame.HealthLabel = healthLabel
end

local function onUnitHealthChanged(_, nameplate, text)
    if not nameplate.UnitFrame.HealthLabel then
        createHealthLabel(nameplate)
    else
        nameplate.UnitFrame.HealthLabel:UpdateText(text)
    end
end

ns.bus:RegisterEvent(name .. "_UPDATE_NAMEPLATE_HEALTH", onUnitHealthChanged)
