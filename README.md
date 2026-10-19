# BetterNamePlates

Lightweight addon that adds extras to the default nameplates, including a custom label on the nameplate health bar and casting-time display on the cast bar.

## Usage
- Open options: use /betternameplates or /bnp, or via Interface -> AddOns.
- Configuration overview:
	- Enable or disable the custom label on health bar.
	- Allowed to use custom tokens to retrieve dynamic data on health bar label.
		- `%NAME%` -> Unit name
		- `%PERCENT%` -> Health percentage (99%)
		- `%PERCENT1%` -> Health percentage with 1 decimal place (37.3%)
		- `%PERCENT2%` -> Health percentage with 2 decimal places (44.12%)
		- `%CURRENT%` -> Current health (7489)
		- `%MISSING%` -> Missing health (-211)
		- `%MAX%` -> Maximum health (7700)
	- Modify the font size for this health label (Min 6)
	- Enable or disable the casting time on cast bar (nameplate only)

	On WoW 12.0 and newer, protected health values may be returned as secret values
	during restricted gameplay. The health label displays `?` for tokens that cannot
	be safely read or formatted by addon code.

## Features
- Class-colored friendly player nameplates.
- Optional class-colored enemy nameplates.
- Optional Shaman color override on Classic clients.
- Lightweight health label with customizable format.
- Casting time and spell-name display for nameplate cast bars.
- In-game options panel integrated with the default Settings UI.
- Slash commands for quick access to options.
- Localization support for English, Spanish, German, French, Italian, Portuguese, Russian, Korean, and Chinese.

## Commands
- /betternameplates  - open the options panel
- /bnp - shortcut to the same options
