local name, ns = ...
local L = ns.L

local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["OPTIONS_TITLE"])

-- Options
local healthSection = builder:CreateSection(L["OPTIONS_HEALTH_LABEL_TITLE"])
healthSection:AddCheckBox(L["OPTIONS_COLORED_NAMEPLATES_CB"], "coloredNameplates")
healthSection:AddCheckBox(L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"], "enemyColoredNameplates")
healthSection:AddCheckBox(L["OPTIONS_DISPLAY_HEALTH_CB"], "displayHealth")
healthSection:AddText(L["OPTIONS_HEALTH_FORMAT_DESC1"])
healthSection:AddEditBox(L["OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", { width = 300 })
healthSection:AddEditBox(L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"], "fontSize", { width = 50 })

local castBarSection = builder:CreateSection(L["OPTIONS_CAST_LABEL_TITLE"])
castBarSection:AddCheckBox(L["OPTIONS_DISPLAY_CAST_CB"], "displayCast")

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
