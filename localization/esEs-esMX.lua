local name, ns = ...
local L = ns.L

if ns.locale == "esES" or ns.locale == "esMX" then
    L["LKEY_OPTIONS_TITLE"] = name .. " " .. "Opciones"

    L["LKEY_OPTIONS_NAMEPLATES_TITLE"] = "Placas de Nombre"
    L["LKEY_OPTIONS_CLASS_COLOR_CB"] = "Colorear Placas por Clase"
    L["LKEY_OPTIONS_SHAMAN_COLOR_CB"] = "Usar Color de Chamán para Chamanes"
end
