local name, ns = ...
local L = ns.L

L["LKEY_TITLE_SETUP"] = name
L["LKEY_MESSAGE_RELOAD"] = "First time setup detected.\nPlease configure the UI."
L["LKEY_BUTTON_RELOAD"] = "Configure UI"

L["LKEY_OPTIONS_TITLE"] = name .. " " .. "Options"

L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"] = "Health Bar"
L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"] = "Display custom text on health bar"
L["LKEY_OPTIONS_HEALTH_FORMAT_DESC1"] = "" 
    .. "· %NAME%       - Unit Name\n" 
    .. " · %PERCENT%   - Health Percentage (99%)\n"
    .. " · %PERCENT1% - 1 decimal point for health Percentage (37.3%)\n"
    .. " · %PERCENT2% - 2 decimal points for health Percentage (44.12%)\n"
    .. " · %CURRENT%  - Current Health (7489)\n"
    .. " · %DEFICIT%     - Health Deficit (-211)\n"
    .. " · %MAX%         - Maximum Health (7700)"
L["LKEY_OPTIONS_HEALTH_FORMAT_EB"] = "Format"
L["LKEY_OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "Font Size (Min 6)"

L["LKEY_OPTIONS_CAST_LABEL_TITLE"] = "Cast Bar"
L["LKEY_OPTIONS_DISPLAY_CAST_CB"] = "Display casting time on cast bar"