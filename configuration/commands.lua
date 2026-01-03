local name, ns = ...

SLASH_BETTERNAMEPLATES1 = "/betternameplates"
SLASH_BETTERNAMEPLATES2 = "/bnp"


local function openSettings()
    if Settings and Settings.OpenToCategory and ns.settingsCategory then
        Settings.OpenToCategory(ns.settingsCategory:GetID())
    end
end

SlashCmdList.BETTERNAMEPLATES = function(msg)
    msg = (msg or ""):match("^%s*(.-)%s*$"):lower()

    if msg == "" or msg == "config" or msg == "options" or msg == "settings" then
        return openSettings()
    else
        print("|cffffd200" .. name  .. ":|r Unknown Command:", msg)
    end
end