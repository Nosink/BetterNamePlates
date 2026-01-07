local _, ns = ...
local L = ns.L

local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
builder:CreateSection(L["LKEY_OPTIONS_NAMEPLATES_TITLE"])
local classColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_CLASS_COLOR_CB"], "classColor")
local cVarClassColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_CVAR_CLASS_COLOR_CB"], "cVarClassColor")
local shamanColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_SHAMAN_COLOR_CB"], "shamanColor")

builder:CreateSection(L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"])
local displayHealthCB = builder:CreateCheckBox(L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"], "displayHealth")
builder:CreateText("")
builder:CreateText(L["LKEY_OPTIONS_HEALTH_FORMAT_DESC1"])
builder:CreateText("")
local healthFormatEB = builder:CreateEditBox(L["LKEY_OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", 300)

-- Register
builder:Register()

local function onShow()
    classColorCB:FetchFromDB()
    cVarClassColorCB:FetchFromDB()
    shamanColorCB:FetchFromDB()
    displayHealthCB:FetchFromDB()
    healthFormatEB:FetchFromDB()
end

ns:HookScript(builder.optionsPanel, "OnShow", onShow)
