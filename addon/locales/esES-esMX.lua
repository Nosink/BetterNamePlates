local name, ns = ...
local L = ns.L

if ns.locale == "esES" or ns.locale == "esMX" then

    L["LKEY_TITLE_SETUP"] = name
    L["LKEY_MESSAGE_RELOAD"] = "Primera configuración detectada.\nPor favor, configure la interfaz."
    L["LKEY_BUTTON_RELOAD"] = "Configurar Interfaz"

    L["LKEY_OPTIONS_TITLE"] = name .. " " .. "Opciones"

    L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"] = "Barra de Salud"
    L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"] = "Mostrar texto personalizado en la barra de salud"
    L["LKEY_OPTIONS_HEALTH_FORMAT_DESC1"] = "" 
        .. "· %NAME%       - Nombre de la unidad\n" 
        .. " · %PERCENT%   - Porcentaje de salud (99%)\n"
        .. " · %PERCENT1% - 1 decimal para el porcentaje de salud (37.3%)\n"
        .. " · %PERCENT2% - 2 decimales para el porcentaje de salud (44.12%)\n"
        .. " · %CURRENT%  - Salud actual (7489)\n"
        .. " · %DEFICIT%     - Déficit de salud (-211)\n"
        .. " · %MAX%         - Salud máxima (7700)"
    L["LKEY_OPTIONS_HEALTH_FORMAT_EB"] = "Formato"
    L["LKEY_OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "Tamaño de Fuente (Mín 6)"

    L["LKEY_OPTIONS_CAST_LABEL_TITLE"] = "Barra de Lanzamiento"
    L["LKEY_OPTIONS_DISPLAY_CAST_CB"] = "Mostrar tiempo de lanzamiento en la barra de lanzamiento"

end
