local name, ns = ...

function ns:GetNamePlate(unitToken)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitToken)
    if not nameplate then return end
    return nameplate
end

function ns:GetAllNameplates()
    local nameplates = {}
    for _, nameplate in pairs(C_NamePlate.GetNamePlates()) do
        table.insert(nameplates, nameplate)
    end
    return nameplates
end

local function onAddonLoaded(_, addOnName)
    if addOnName ~= name then return end
    ns.bus:TriggerEvent(name .. "_ADDON_LOADED")
end

local function onLoad()
    ns.bus:TriggerEvent(name .. "_VARIABLES_LOADED")
end

local function onVariablesLoaded(_)
    ns.database.Load(onLoad)
end

ns.bus:RegisterEvent("ADDON_LOADED", onAddonLoaded)
ns.bus:RegisterEvent("VARIABLES_LOADED", onVariablesLoaded)
