local name, ns = ...

local L = ns.L

local LibEventBus = LibStub("LibEventBus-1.0")
BNPBus = LibEventBus:NewBus("BNPBus", true)

function ns:GetNamePlate(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken)
    if not nameplate then return end

    return nameplate
end

local function displayReloadPanel()
    local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetSize(300, 110)
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 11, edgeSize = 11,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)
    frame:SetBackdropBorderColor(1, 1, 1, 0.8)
    frame:Show()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(L["LKEY_TITLE_RELOAD"])

    local message = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    message:SetPoint("TOP", title, "BOTTOM", 0, -10)
    message:SetText(L["LKEY_MESSAGE_RELOAD"])

    local button = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    button:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    button:SetSize(100, 30)
    button:SetText(L["LKEY_BUTTON_RELOAD"])
    button:SetScript("OnClick", function()
        SetCVar("ShowClassColorInFriendlyNameplate", "1")
        ReloadUI()
    end)

end

local function evaluateClassColorCVar()
    local value = GetCVar("ShowClassColorInFriendlyNameplate")
    if value == "0" then
        displayReloadPanel()
    end
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end

    evaluateClassColorCVar()

    BNPBus:TriggerEvent(name .. "_ADDON_LOADED")
end

BNPBus:RegisterEvent("ADDON_LOADED", onAddonLoaded)

-- /run SetCVar("ShowClassColorInFriendlyNameplate", "0")