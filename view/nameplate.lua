local name, ns = ...

local data = ns.data
local settings = ns.settings

local function setNamePlateColorByClass(healthBar, classFilename)
    local color = data.classColor[classFilename]
    healthBar.barTexture:SetVertexColor(color.r, color.g, color.b, 1)
end

local function restoreNamePlateColor(healthBar)
    healthBar.barTexture:SetVertexColor(0, 0, 1, 1)
end

local function onNamePlateAdded(driverFrame, namePlateUnitToken)
    local guid = UnitGUID(namePlateUnitToken)
    local unitType = guid and guid:match("^(%a+)-") or ""
    if unitType ~= "Player" then return end

    local healthBar = driverFrame.UnitFrame.healthBar
    local classFilename = UnitClassBase(namePlateUnitToken)

    if settings.IsClassColorEnabled() then
        setNamePlateColorByClass(healthBar, classFilename)
    else
        restoreNamePlateColor(healthBar)
    end
end

local function onSettingsChanged(_, key)
    if (key == "classColor") then
        local namePlates = C_NamePlate.GetNamePlates()
        for _, namePlate in ipairs(namePlates) do
            onNamePlateAdded(namePlate, namePlate.namePlateUnitToken)
        end
    end
end

ns:HookSecureFunc(NamePlateBaseMixin, "OnAdded", onNamePlateAdded)
ns:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)