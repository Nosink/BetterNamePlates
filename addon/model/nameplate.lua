local name, ns = ...

local includeForbidden = false

local function createHealthLabel(nameplate)
    if nameplate.UnitFrame.HealthLabel then return end

    local healthBar = nameplate.UnitFrame.healthBar
    if not healthBar then return end

    local healthLabel = healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthLabel:SetPoint("LEFT", healthBar, "LEFT", 1, 0)

    healthLabel.UpdateFontSize = function(self)
        local file, _, flags = self:GetFont()
        self:SetFont(tostring(file), ns.db.fontSize, flags)
    end

    healthLabel:UpdateFontSize()

    healthLabel:SetJustifyV("MIDDLE")
    healthLabel:SetJustifyH("LEFT")
    healthLabel:SetTextColor(1, 1, 1, 1)

    healthLabel.UpdateText = function(self)
        self:SetText(ns.db.healthFormat or "NAMEPLATE")
        self:Show();
    end

    healthLabel:UpdateText()

    nameplate.UnitFrame.HealthLabel = healthLabel
end

local function onNamePlateAdded(_, unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken, includeForbidden)

    createHealthLabel(nameplate)

    ns.bus:TriggerEvent(name .. "_NAME_PLATE_READY", nameplate)
end

ns.bus:RegisterEvent("NAME_PLATE_UNIT_ADDED", onNamePlateAdded)
