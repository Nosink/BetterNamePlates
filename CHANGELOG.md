# Changelog

## [1.3.0] - 09/02/2026

### Added
- CastLabel control to display casting or channeling information in cast bar.

## Removed
- Old monolith about fetch class names and re-color bar texture of nameplate `HealthBarsContainer`

### Fixed
- NO more crashes on Dungeons.
	- Control over `FORBIDDEN_NAME_PLATE_···" Events and other namepalte events related.

### Changed
- Forced to use of CVars to improve performance and avoid color refreshing errors
 
--- 

## [1.2.0] - 23/01/2026
Allow extra customization to health label

### Added
- Added edit box to Settings to input the font size for health label

---

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