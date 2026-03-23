local name, ns = ...

ns.db = ns.db or {}
ns.dbHandle = ns.dbHandle or nil

local LibSharedVariables = LibStub("LibSharedVariables-1.0")

local defaults = {

    displayHealth = true,
    healthFormat = "%PERCENT1%",
    fontSize = 10,
    refreshRate = 0.1,

    displayCast = true,
}

local defaultsPC = {

}

local function handleOnLoadDatabase(db)
    ns.db = db
    BNPBus:TriggerEvent(name .. "_VARIABLES_LOADED")
end

local function onVariablesLoaded()
    LibSharedVariables:Load(name, defaults, defaultsPC, handleOnLoadDatabase)
end

BNPBus:RegisterEvent("VARIABLES_LOADED", onVariablesLoaded)
