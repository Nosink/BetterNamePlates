# BetterNamePlates

Lightweight Classic Era addon that give some extras to the default NamePlates, allow class color frames.

## Usage
- Open options: use /betternameplates or /bnp, or via Interface -> AddOns.
- Configuration overview:
	- Class Color: colors friendly player nameplates by their class.
	- Use CVar Class Colors: toggles Blizzard's `ShowClassColorInFriendlyNameplate` CVar. When enabled, Blizzard handles most coloring; the addon ensures consistency where needed.
	- Shaman Color: choose whether SHAMAN uses its class color or the PALADIN color (useful for personal preference or visibility).
	- Display Health: shows a small health text on the health bar.
	- Health Format: customize the text using tokens:
		- %PERCENT% → integer percent (e.g., 67%)
		- %PERCENT1% → one decimal (e.g., 67.4%)
		- %PERCENT2% → two decimals (e.g., 67.43%)
		- %CURRENT% → current health value
		- %MAX% → max health value
	- Refresh Rate: how often the health text updates (0.1–1.0s; default 0.1s).
  

## Features
- Class-colored friendly player nameplates.
- Optional SHAMAN color preference (Blizzard default or PALADIN color).
- Lightweight health label with customizable format and refresh rate.
- In-game options panel integrated with the default Settings UI.
- Slash commands for quick access to options.
- Localization support (English, Spanish/esMX).

## Compatibility
- WoW Classic Era 1.15.8.

## Commands
- /betternameplates  - open the options panel
- /bnp               - shortcut to the same options
