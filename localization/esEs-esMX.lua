local name, ns = ...
local L = ns.L

if ns.locale == "esES" or ns.locale == "esMX" then
    L["LKEY_OPTIONS_TITLE"] = name .. " " .. "Opciones"

    L["LKEY_OPTIONS_NAMEPLATES_TITLE"] = "Placas de Nombre"
    L["LKEY_OPTIONS_CLASS_COLOR_CB"] = "Colorear Placas por Clase"
    L["LKEY_OPTIONS_CVAR_CLASS_COLOR_CB"] = "Usar Optimicación de Color de Clase (Requiere Recargar Interfaz)"

    L["LKEY_OPTIONS_HEALTH_LABEL_TITLE"] = "Etiqueta de Salud"
    L["LKEY_OPTIONS_DISPLAY_HEALTH_CB"] = "Mostrar Salud en la Placa"
    L["LKEY_OPTIONS_HEALTH_FORMAT_DESC"] = "%PERCENT% - Porcentaje de Salud, %CURRENT% - Valor de Salud, %MAX% - Salud Máxima"
    L["LKEY_OPTIONS_HEALTH_FORMAT_EB"] = "Formato"
    L["LKEY_OPTIONS_HEALTH_LABEL_FONT_SIZE_EB"] = "Tamaño de Fuente (Mín 6)"
    L["LKEY_OPTIONS_HEALTH_REFRESH_RATE_SL"] = "Frecuencia de Actualización de Salud (Segundos)"

end
