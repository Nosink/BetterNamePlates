local name, ns = ...

local defaults = {

    isFirstLoad = true,

    coloredNameplates = true,
    enemyColoredNameplates = true,

    shamanColor = true,

    displayHealth = "1",
    healthFormat = "%PERCENT1%",
    fontSize = 10,

 = true,
    displayCastName = true,
}

local defaultsPC = {
}

ns.database.Register(defaults, defaultsPC)
