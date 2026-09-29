local name, ns = ...

local L = ns.L

local function displayReloadPanel()
    local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetSize(250, 120)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 11,
        edgeSize = 11,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)
    frame:SetBackdropBorderColor(1, 1, 1, 0.8)
    frame:Show()

    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    local fontName, _, flags = title:GetFont()
    title:SetFont(tostring(fontName), 24, flags)
    title:SetTextColor(0.2, 0.6, 1, 1)
    title:SetText(L["TITLE_SETUP"])

    local separator = frame:CreateTexture(nil, "BORDER")
    separator:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -38)
    separator:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -38)
    separator:SetColorTexture(1, 1, 1, 0.15)
    separator:SetHeight(2)

    local message = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    message:SetTextColor(1, 1, 1, 1)
    local fontName, _, flags = title:GetFont()
    message:SetFont(tostring(fontName), 14, flags)
    message:SetPoint("TOP", title, "BOTTOM", 0, -12)
    message:SetText(L["MESSAGE_RELOAD"])

    local button = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    button:SetSize(100, 30)
    button:SetText(L["BUTTON_RELOAD"])
    button:SetScript("OnClick", function()
        ns.bus:TriggerEvent(name .. "_ENABLE_CVAR_REQUEST")
    end)
end

ns.bus:RegisterEvent(name .. "_CLASS_COLOR_CVAR_DISABLED", displayReloadPanel)
