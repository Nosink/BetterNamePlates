local _, ns = ...
local L = ns.L

if ns.locale == "zhTW" then

L["OPTIONS_TITLE"] = "更好的姓名板"
L["OPTIONS_HEALTH_LABEL_TITLE"] = "生命條"
L["OPTIONS_COLORED_NAMEPLATES_CB"] = "依職業為姓名板著色"
L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"] = "依職業為敵方姓名板著色"
L["OPTIONS_SHAMAN_COLORED_NAMEPLATES_CB"] = "依職業為薩滿姓名板著色"
L["OPTIONS_HEALTH_LABEL_FORMAT_DD"] = "顯示生命值對象"
L["HEALTH_FORMAT_NONE"] = "不顯示"
L["HEALTH_FORMAT_ONLY_PLAYERS"] = "僅玩家"
L["HEALTH_FORMAT_ONLY_NPCS"] = "僅中立NPC"
L["HEALTH_FORMAT_PLAYERS_AND_NPCS"] = "玩家和中立NPC"
L["OPTIONS_HEALTH_FORMAT_DESC1"] = ""
    .. " · %NAME%       - 單位名稱\n"
    .. " · %PERCENT%   - 生命值百分比（99%）\n"
    .. " · %PERCENT1% - 1位小數的生命值百分比（37.3%）\n"
    .. " · %PERCENT2% - 2位小數的生命值百分比（44.12%）\n"
    .. " · %CURRENT%  - 目前生命值（7489）\n"
    .. " · %MISSING%     - 缺失生命值（-211）\n"
    .. " · %MAX%         - 最大生命值（7700）"
L["OPTIONS_HEALTH_FORMAT_EB"] = "格式"
L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "字型大小（最小6）"
L["OPTIONS_CAST_LABEL_TITLE"] = "施法條"
L["OPTIONS_DISPLAY_CAST_TIME_CB"] = "在施法條顯示施法時間"
L["OPTIONS_DISPLAY_CAST_NAME_CB"] = "在施法條顯示法術名稱"
L["COMMAND_USE"] = "使用"
L["COMMAND_OR"] = "或"
L["COMMAND_DESCRIPTION"] = "開啟設定"
L["COMMAND_VERSION"] = "版本"

end
