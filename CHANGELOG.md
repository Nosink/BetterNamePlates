# Changelog

## [1.4.0] - 19/10/2026

### Added
- Support for Retail and Classic interface versions `50504`, `40402`, `30405`, `20506`, and `11509`.
- Localized addon metadata and interface text for English, Spanish, German French, Italian, Portuguese, Russian, Korean, Simplified Chinese, and Traditional Chinese.
- Configurable health-label display for players, NPCs, or both.
- Configurable health-label font size.
- Optional enemy nameplate coloring and Shaman color override on Classic.

### Changed
- Replaced the old configuration and MVC modules with a modular model, view,
  and controller structure.
- Moved the addon to the Blizzard Settings UI and added controls for health
  display, formatting, font size, cast time, and cast name.
- Replaced the external library layout with the embedded event bus module.
- Expanded the health-label token support with `%NAME%`, `%PERCENT%`,
  `%PERCENT1%`, `%PERCENT2%`, `%CURRENT%`, `%MISSING%`, and `%MAX%`.

### Fixed
- Improved Shaman health-bar color handling on Classic clients.
- Improved handling of secret values and nameplate lifecycle events.

---

## [1.3.0] - 09/02/2026

### Added
- Cast-label control to display casting or channeling information in the cast bar.

## Removed
- Old monolith used to fetch class names and recolor the nameplate
  `HealthBarsContainer`.

### Fixed
- Prevented dungeon crashes by controlling `FORBIDDEN_NAME_PLATE_*` and other
  nameplate-related events.

### Changed
- Forced use of CVars to improve performance and avoid color-refreshing errors.
 
---

## [1.2.0] - 23/01/2026
Added extra health-label customization.

### Added
- Added a Settings edit box for the health-label font size.

---

## [1.1.1] - 14/01/2026
- Fixed the installation process.
- Added Classic interface support.

---

## [1.1.0] - 14/01/2026
- Added Burning Crusade Classic support.

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