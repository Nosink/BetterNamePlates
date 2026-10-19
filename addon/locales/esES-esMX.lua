local name, ns = ...
local L = ns.L

if ns.locale == "esES" or ns.locale == "esMX" then

L["OPTIONS_TITLE"] = "Placas de nombre mejoradas"
L["OPTIONS_HEALTH_LABEL_TITLE"] = "Barra de vida"
L["OPTIONS_COLORED_NAMEPLATES_CB"] = "Colorear las placas según la clase"
L["OPTIONS_COLORED_ENEMY_NAMEPLATES_CB"] = "Colorear las placas enemigas según la clase"
L["OPTIONS_SHAMAN_COLORED_NAMEPLATES_CB"] = "Colorear las placas de los chamanes según la clase"
L["OPTIONS_HEALTH_LABEL_FORMAT_DD"] = "Mostrar vida para"
L["HEALTH_FORMAT_NONE"] = "Ninguno"
L["HEALTH_FORMAT_ONLY_PLAYERS"] = "Solo jugadores"
L["HEALTH_FORMAT_ONLY_NPCS"] = "Solo PNJ neutrales"
L["HEALTH_FORMAT_PLAYERS_AND_NPCS"] = "Jugadores y PNJ neutrales"
L["OPTIONS_HEALTH_FORMAT_DESC1"] = ""
    .. " · %NAME%       - Nombre de la unidad\n"
    .. " · %PERCENT%   - Porcentaje de vida (99 %)\n"
    .. " · %PERCENT1% - Porcentaje de vida con 1 decimal (37,3 %)\n"
    .. " · %PERCENT2% - Porcentaje de vida con 2 decimales (44,12 %)\n"
    .. " · %CURRENT%  - Vida actual (7489)\n"
    .. " · %MISSING%     - Vida faltante (-211)\n"
    .. " · %MAX%         - Vida máxima (7700)"
L["OPTIONS_HEALTH_FORMAT_EB"] = "Formato"
L["OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "Tamaño de fuente (mín. 6)"
L["OPTIONS_CAST_LABEL_TITLE"] = "Barra de lanzamiento"
L["OPTIONS_DISPLAY_CAST_TIME_CB"] = "Mostrar el tiempo de lanzamiento"
L["OPTIONS_DISPLAY_CAST_NAME_CB"] = "Mostrar el nombre del hechizo"
L["COMMAND_USE"] = "Usa"
L["COMMAND_OR"] = "o"
L["COMMAND_DESCRIPTION"] = "para abrir las opciones"
L["COMMAND_VERSION"] = "Versión"

end
