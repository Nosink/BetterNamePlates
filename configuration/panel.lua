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
local shamanColorCB = builder:CreateCheckBox(L["LKEY_OPTIONS_SHAMAN_COLOR_CB"], "shamanColor")

-- Register
builder:Register()

local function onShow()
    classColorCB:FetchFromDB()
    shamanColorCB:FetchFromDB()
end

ns:HookScript(builder.optionsPanel, "OnShow", onShow)
