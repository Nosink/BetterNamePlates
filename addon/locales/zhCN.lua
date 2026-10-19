local _, ns = ...
local L = ns.L

if ns.locale == "zhCN" then

L["OPTIONS_TITLE"] = "更好的姓名板"
L["OPTIONS_HEALTH_LABEL_TITLE"] = "生命条"
L["OPTIONS_COLORED_NAMEPLATES_CB"] = "根据职业为姓名板着色"
L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"] = "根据职业为敌方姓名板着色"
L["OPTIONS_SHAMAN_COLORED_NAMEPLATES_CB"] = "根据职业为萨满姓名板着色"
L["OPTIONS_HEALTH_LABEL_FORMAT_DD"] = "显示生命值对象"
L["HEALTH_FORMAT_NONE"] = "不显示"
L["HEALTH_FORMAT_ONLY_PLAYERS"] = "仅玩家"
L["HEALTH_FORMAT_ONLY_NPCS"] = "仅中立NPC"
L["HEALTH_FORMAT_PLAYERS_AND_NPCS"] = "玩家和中立NPC"
L["OPTIONS_HEALTH_FORMAT_DESC1"] = ""
    .. " · %NAME%       - 单位名称\n"
    .. " · %PERCENT%   - 生命值百分比（99%）\n"
    .. " · %PERCENT1% - 1位小数的生命值百分比（37.3%）\n"
    .. " · %PERCENT2% - 2位小数的生命值百分比（44.12%）\n"
    .. " · %CURRENT%  - 当前生命值（7489）\n"
    .. " · %MISSING%     - 缺失生命值（-211）\n"
    .. " · %MAX%         - 最大生命值（7700）"
L["OPTIONS_HEALTH_FORMAT_EB"] = "格式"
L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "字体大小（最小6）"
L["OPTIONS_CAST_LABEL_TITLE"] = "施法条"
L["OPTIONS_DISPLAY_CAST_TIME_CB"] = "在施法条显示施法时间"
L["OPTIONS_DISPLAY_CAST_NAME_CB"] = "在施法条显示法术名称"
L["COMMAND_USE"] = "使用"
L["COMMAND_OR"] = "或"
L["COMMAND_DESCRIPTION"] = "打开设置"
L["COMMAND_VERSION"] = "版本"

end
