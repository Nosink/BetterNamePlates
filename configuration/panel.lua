local _, ns = ...
local L = ns.L

local bus = LibStub("LibEventBus-1.0")

local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
builder:CreateSection(L["LKEY_OPTIONS_NAMEPLATES_TITLE"])
local classColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_CLASS_COLOR_CB"], "classColor")
local cVarClassColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_CVAR_CLASS_COLOR_CB"], "cVarClassColor")

builder:CreateSection(L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"])
local displayHealthCB = builder:CreateCheckBox(L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"], "displayHealth")
builder:CreateText("")
builder:CreateText(L["LKEY_OPTIONS_HEALTH_FORMAT_DESC1"])
builder:CreateText("")
local fontSizeEB = builder:CreateEditBox(L["LKEY_OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"], "fontSize", 50)
builder:CreateText("")
local healthFormatEB = builder:CreateEditBox(L["LKEY_OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", 300)

local healthRefreshRateSL = builder:CreateSlider(L["LKEY_OPTIONS_HEALTH_REFRESH_RATE_SL"], "refreshRate", 0.1, 1.0, 0.1)

-- Register
builder:Register()

local function onShow()
    classColorCB:FetchFromDB()
    cVarClassColorCB:FetchFromDB()
    displayHealthCB:FetchFromDB()
    healthFormatEB:FetchFromDB()
    fontSizeEB:FetchFromDB()
    healthRefreshRateSL:FetchFromDB()
end

bus:HookScript(builder.optionsPanel, "OnShow", onShow)
