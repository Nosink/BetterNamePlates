# Changelog

## [1.1.1] - 14/01/2026
Fixed installation processs
Added interface support for classic

---

## [1.1.0] - 14/01/2026
Work for TBC

---

## [1.0.0] - 11/01/2026
Initial release of Better Nameplates.

### Added
- Class-colored friendly player nameplates driven by an internal event bus.
- Option to choose SHAMAN color: Blizzard default SHAMAN color or PALADIN color alternative.
- Health label overlay on the nameplate health bar with customizable format tokens:
	- %PERCENT%, %PERCENT1%, %PERCENT2%, %CURRENT%, %MAX%
- Health label refresh rate setting (0.1–1.0s; default 0.1s).
- In-game Settings panel with sections for Nameplates and Health Label, including checkboxes, edit box, and slider.
- Slash commands: /betternameplates and /bnp (aliases: config/options/settings open the panel).
- Integration with Blizzard CVar `ShowClassColorInFriendlyNameplate` for class color handling when desired.
- SavedVariables to persist configuration between sessions.
- Localization scaffolding with English (enUS) and Spanish (esES/esMX) strings.

### Compatibility
- WoW Classic Era 1.15.8

### Notes
- Only friendly player nameplates are recolored; enemies/NPCs are not modified.
- When CVar-based class colors are enabled, Blizzard handles most coloring; the addon updates select classes to maintain consistency.
- Health label hides automatically if Display Health is disabled.
- Other nameplate-overhaul addons may override or conflict with these visuals.