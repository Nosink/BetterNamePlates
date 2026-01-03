local name, ns = ...

local function initializeVars()
    ns.current = GetMoney()
    ns.session = 0
end

local function onPlayerEnteringWorld()

    local currentDate = date("%Y-%m-%d", GetServerTime())
    print(currentDate)

    initializeVars()

    ns:TriggerEvent(name .. "_ADDON_LOADED")
end

ns:RegisterEvent("PLAYER_ENTERING_WORLD", onPlayerEnteringWorld)