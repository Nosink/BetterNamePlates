local _, ns = ...
local L = ns.L

local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
builder:CreateSection(L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"])
local displayHealthCB = builder:CreateCheckBox(L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"], "displayHealth")
builder:CreateText("")
builder:CreateText(L["LKEY_OPTIONS_HEALTH_FORMAT_DESC1"])
builder:CreateText("")
local fontSizeEB = builder:CreateEditBox(L["LKEY_OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"], "fontSize", 50)
builder:CreateText("")
local healthFormatEB = builder:CreateEditBox(L["LKEY_OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", 300)

builder:CreateSection(L["LKEY_OPTIONS_CAST_LABEL_TITLE"])
local displayCastCB = builder:CreateCheckBox(L["LKEY_OPTIONS_DISPLAY_CAST_CB"], "displayCast")

-- Register
builder:Register()

local function onShow()
    displayHealthCB:FetchFromDB()
    healthFormatEB:FetchFromDB()
    fontSizeEB:FetchFromDB()
    displayCastCB:FetchFromDB()
end

BNPBus:HookScript(builder.optionsPanel, "OnShow", onShow)
