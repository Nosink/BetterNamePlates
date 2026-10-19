local name, ns = ...
local L = ns.L

local enums = ns.enums
local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["OPTIONS_TITLE"])

-- Options
local healthSection = builder:CreateSection(L["OPTIONS_HEALTH_COLOR_LABEL_TITLE"])
healthSection:AddCheckBox(L["OPTIONS_COLORED_NAMEPLATES_CB"], "coloredNameplates")
healthSection:AddCheckBox(L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"], "enemyColoredNameplates")
if (ns.expansion == enums.expansion.CLASSIC) then
    healthSection:AddCheckBox(L["OPTIONS_SHAMAN_COLORED_NAMEPLATES_CB"], "shamanColor")
end
local healthTextSection = builder:CreateSection(L["OPTIONS_HEALTH_TEXT_LABEL_TITLE"])
healthTextSection:AddDropDown(L["OPTIONS_HEALTH_LABEL_FORMAT_DD"], "displayHealth", {
    { text = L["HEALTH_FORMAT_NONE"],             value = "0" },
    { text = L["HEALTH_FORMAT_ONLY_PLAYERS"],     value = "1" },
    { text = L["HEALTH_FORMAT_ONLY_NPCS"],        value = "2" },
    { text = L["HEALTH_FORMAT_PLAYERS_AND_NPCS"], value = "3" },
}, { width = 100 })
healthTextSection:AddText(L["OPTIONS_HEALTH_FORMAT_DESC1"], { offset = { x = 0, y = -5 } })
healthTextSection:AddEditBox(L["OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", { width = 300 })
healthTextSection:AddEditBox(L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"], "fontSize",
    { width = 50, isNumeric = true, validator = builder.inRangeValidator(6, 48) })

local castBarSection = builder:CreateSection(L["OPTIONS_CAST_LABEL_TITLE"])
castBarSection:AddCheckBox(L["OPTIONS_DISPLAY_CAST_TIME_CB"], "displayCast")
castBarSection:AddCheckBox(L["OPTIONS_DISPLAY_CAST_NAME_CB"], "displayCastName")

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
