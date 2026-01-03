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

-- Register
builder:Register()

local function onShow()
    classColorCB:FetchFromDB()
end

ns:HookScript(builder.optionsPanel, "OnShow", onShow)
