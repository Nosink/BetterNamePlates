local name, ns = ...

local defaults = {

    displayHealth = true,
    healthFormat = "%PERCENT1%",
    fontSize = 10,
    refreshRate = 0.1,

    displayCast = true,
}

local defaultsPC = {
}

ns.database.Register(defaults, defaultsPC)
