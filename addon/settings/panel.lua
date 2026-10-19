local name, ns = ...
local L = ns.L

local enums = ns.enums
local builder = ns.builder

-- Panel Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["OPTIONS_TITLE"])

-- Options
local healthSection = builder:CreateSection(L["OPTIONS_HEALTH_LABEL_TITLE"])
healthSection:AddCheckBox(L["OPTIONS_COLORED_NAMEPLATES_CB"], "coloredNameplates")
healthSection:AddCheckBox(L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"], "enemyColoredNameplates")
if (ns.expansion == enums.expansion.CLASSIC) then
    healthSection:AddCheckBox(L["OPTIONS_SHAMAN_COLORED_NAMEPLATES_CB"], "shamanColor")
end
healthSection:AddDropDown(L["OPTIONS_HEALTH_LABEL_FORMAT_DD"], "displayHealth", {
    { text = "NONE",           value = "0" },
    { text = "only players",   value = "1" },
    { text = "only npcs",      value = "2" },
    { text = "players & npcs", value = "3" },
}, { width = 100 })
healthSection:AddText(L["OPTIONS_HEALTH_FORMAT_DESC1"], { offset = { x = 0, y = -5 } })
healthSection:AddEditBox(L["OPTIONS_HEALTH_FORMAT_EB"], "healthFormat", { width = 300 })
healthSection:AddEditBox(L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"], "fontSize",
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
