local name, ns = ...

local bus = LibStub("LibEventBus-1.0")

local settings = ns.settings

local function onNamePlateHealthLabelUpdateRequest(_, unit)
    if not unit or not unit.healthBar.label then return end

    if settings.IsHealthDisplayEnabled() then
        unit.healthBar.label:SetText(unit.text)
    else
        unit.healthBar.label:SetText("")
    end
end


bus:RegisterEvent(name .. "_HEALTH_LABEL_UPDATE_REQUEST", onNamePlateHealthLabelUpdateRequest)