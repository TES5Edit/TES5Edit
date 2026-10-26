# xEdit

xEdit by ElminsterAU. The editing and conflict-resolution tool for Bethesda game plugins — Oblivion through Starfield.

## Maintainers and Contributors

**Author and upstream maintainer:** [ElminsterAU](https://github.com/ElminsterAU) (since 2006)

**Co-maintainer:** [robertgk2017](https://github.com/robertgk2017) — record definitions across all supported game formats, BSArch/BSArchPro, core editor fixes; integration point for incoming contributions

**Regular contributors:** [Jonathan Ostrus](https://github.com/jbostrus), [fireundubh](https://github.com/fireundubh), [eckserah](https://github.com/eckserah)

**LOD tooling (xLODGen/DynDOLOD):** Sheson

**Historical maintainers (2012–2019):** Hlp, Zilav, Sharlikran

See the [contributors graph](https://github.com/TES5Edit/TES5Edit/graphs/contributors) and [whatsnew.md](whatsnew.md) for per-release attribution.

## GitHub Issue Tracker

Our [GitHub issue tracker](https://github.com/TES5Edit/TES5Edit/issues) offers a place to submit and discuss feature requests and bug reports. When using it, please ensure that any criticism you provide is constructive.

Please do not use the tracker for general help and support on how to use xEdit.

## Releases

The most recent builds are available through the [xEdit Discord](https://discord.com/invite/5t8RnNQ) in the `#xedit-builds` channel. The archive provided here is generic and works with all current game modes. See the [xEdit Versions](#xedit-versions) table in this document on how to properly use it.

Less frequently updated already renamed packages can be found on the following pages:

### xEdit Releases

- [FO3Edit](http://www.nexusmods.com/fallout3/mods/637)
- [FNVEdit](http://www.nexusmods.com/newvegas/mods/34703)
- [FO4Edit](http://www.nexusmods.com/fallout4/mods/2737)
- [FO4VREdit](http://www.nexusmods.com/fallout4/mods/2737)
- [TES4Edit](http://www.nexusmods.com/oblivion/mods/11536)
- [TES5Edit](http://www.nexusmods.com/skyrim/mods/25859)
- [TES5VREdit](http://www.nexusmods.com/skyrim/mods/25859)
- [SSEEdit](http://www.nexusmods.com/skyrimspecialedition/mods/164)
- [FO76Edit](https://www.nexusmods.com/fallout76/mods/30)
- [SF1Edit](https://www.nexusmods.com/starfield/mods/239)
- [Mirror](https://github.com/TES5Edit/TES5Edit/releases)

### xLODGen Releases

- [FO3LODGen](http://www.nexusmods.com/fallout3/mods/21174)
- [FNVLODGen](http://www.nexusmods.com/newvegas/mods/58562)
- [TES4LODGen](http://www.nexusmods.com/oblivion/mods/15781)
- [TES5LODGen](http://www.nexusmods.com/skyrim/mods/62698)
- [TES5VRLODGen](http://www.nexusmods.com/skyrim/mods/62698)
- [SSELODGen](http://www.nexusmods.com/skyrimspecialedition/mods/6642/?)

## User Documentation

### xEdit Cleaning Guide

With the 4.0 update, all previous guides are obsolete. Refer to [xEdit Quick Auto Clean](https://tes5edit.github.io/docs/7-mod-cleaning-and-error-checking.html#ThreeEasyStepstocleanMods).

### Manuals

- [Fallout3 Training Manual](https://www.nexusmods.com/fallout3/mods/8629) for FO3Edit (applies to all game versions)
- [Fallout New Vegas Training Manual](https://www.nexusmods.com/newvegas/mods/38413) for FO3Edit (applies to all game versions)

### Online Documentation

EpFwip started an HTML conversion of the Fallout 3 Training Manual many years ago. With the help of GhPages and Jekyll online documentation for xEdit is now available. New screenshots of the Fallout 3 examples that Miax and JustinOther presented will be added as time permits. Also, the website will continue to evolve over time.

However, for now consider what the Tome of xEdit presents as a current resource for xEdit functionality. The previous PDF file presented step-by-step illustrations of the built-in functions available to xEdit. While the UI itself has had few changes over time the functions work the same and only certain functions are game-specific.

The online documentation is available from the Help button built into the developmental version of xEdit or you can view it [from here](https://tes5edit.github.io/docs/).

## Developer Documentation

Getting started with xEdit development requires a properly configured Delphi environment. The following instructions should get you through the minimal viable setup.

### Install Delphi

If you don't already have a Delphi environment, we recommend using [Delphi 13 Community Edition](https://www.embarcadero.com/products/delphi/starter).

### Install Dependencies

The JCL and JVCL installers need the command-line compiler, which the Community Edition does not include, so the steps below build and install their packages from the IDE instead.

- Download and install [Project Magician](https://www.uweraabe.de/Blog/downloads/download-info/project-magician/).
- Download and install [DDevExtensions](https://github.com/DelphiPraxis/DDevExtensions/releases).
- Launch Delphi and navigate to Tools &rarr; DDevExtensions Options.
- Under Extended IDE Settings, 
  - **enable** the _Disable Package Cache_ option.
- Under Form Designer,
  - **enable** the _Do not store the Explicit properties into the DFM_ option.
- Exit Delphi.
- Clone the xEdit repo (if you haven't already) and initialize submodules (run `git submodule update --init --recursive` from the git root).
- Copy **jcld37win32.inc** from the _External\jcl-inc\\_ directory to the _External\jcl\jcl\source\include\\_ directory.
- Open _External\jcl\jcl\packages\JclPackagesD370.groupproj_.
- Build All, then install all packages (non-runtime packages with green icons).
- Restart Delphi.
- Open _External\jvcl\jvcl\packages\D37 Packages.groupproj_.
- Navigate to Tools &rarr; Options.
- Under Language &rarr; Delphi, add the below paths to the _Library_ option:
  - _{TES5Edit repo}\External\jcl\jcl\lib\d37\win32_
  - _{TES5Edit repo}\External\jcl\jcl\source\include_
- Build All, then install all packages (non-runtime packages with green icons).
- Restart Delphi.
- Navigate to Tools &rarr; Options.
- Under Language &rarr; Delphi, add the below path to the _Library_ option:
  - _{TES5Edit repo}\External\jvcl\jvcl\lib\d37\win32_
- Restart Delphi.
- Open _External\VirtualTrees\Packages\RAD Studio 13\VirtualTreeView.groupproj_.
- Build All, then install **VirtualTreesD370.bpl**.
- Open _External\FileContainer\FileContainer37.groupproj_.
- Build All, then install **FileContainerD37.bpl**.

### Important Note

If you don't have commercial [DevExpress](https://www.devexpress.com/) components, you'll need to open _BethWorkBench.groupproj_ and ensure the Build Configuration is set to `LiteDebug`.

## xEdit versions

All xEdit executable files can support all game modes. To choose which mode to use either:
* Launch the application using the command line argument
* Rename the xEdit executable to include the game mode


| Game                | Executable Name     | Argument     |
|---------------------|---------------------|--------------|
| Enderal             | `EnderalEdit.exe`   | -Enderal     |
| Enderal SE          | `EnderalSEEdit.exe` | -EnderalSE   |
| Oblivion            | `TES4Edit.exe`      | -TES4        |
| Oblivion Remastered | `TES4REdit.exe`     | -TES4R       |
| Skyrim              | `TES5Edit.exe`      | -TES5        |
| Skyrim SE           | `SSEEdit.exe`       | -SSE         |
| Skyrim VR           | `TES5VREdit.exe`    | -TES5VR      |
| Fallout 3           | `FO3Edit.exe`       | -FO3         |
| Fallout: New Vegas  | `FNVEdit.exe`       | -FNV         |
| Fallout 4           | `FO4Edit.exe`       | -FO4         |
| Fallout 4 VR        | `FO4VREdit.exe`     | -FO4VR       |
| Fallout 76          | `FO76Edit.exe`      | -FO76        |
| Starfield           | `SF1Edit.exe`       | -SF1         |

## xEdit Updates

With each new version of xEdit, it is recommended to restore plugins from backups and reclean them. Otherwise, any fixes and updates to the cleaning process won't take effect.

### Changelog

See the [What's New](whatsnew.md) or view the `What's New` tab inside the application.

The Changelog has been moved to the What's New document.
