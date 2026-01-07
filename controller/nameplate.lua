local name, ns = ...

local data = ns.data
local settings = ns.settings

local function useCVar()
    SetCVar("ShowClassColorInNameplate", 1)
end

local function onNamePlateData(_, healthBar, namePlateUnitToken)
    local guid = UnitGUID(namePlateUnitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local color = {r = 0, g = 0, b = 1}
    local classFilename = UnitClassBase(namePlateUnitToken)

    if settings.IsClassColorEnabled() then
        if not settings.IsShamanColorEnabled() and classFilename == "SHAMAN" then
            classFilename = "PALADIN"
        end
        color = data.classColor[classFilename]
    end
    ns:TriggerEvent(name .. "_NAMEPLATE_UPDATE_REQUEST", healthBar, color)
end

ns:RegisterEvent(name .. "_NAMEPLATE_DATA", onNamePlateData)