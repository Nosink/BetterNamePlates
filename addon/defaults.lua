local name, ns = ...

local defaults = {

    isFirstLoad = true,

    coloredNameplates = true,
    enemyColoredNameplates = true,

    displayHealth = true,
    healthFormat = "%PERCENT1%",
    fontSize = 10,

    displayCast = true,
}

local defaultsPC = {
}

ns.database.Register(defaults, defaultsPC)
