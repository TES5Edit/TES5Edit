# xEdit

xEdit 4.0.0 by ElminsterAU. Updates since 2012 include TES5Edit/SSEEdit/FO4Edit by Hlp, Zilav and Sharlikran. LOD management by Sheson.

## GitHub Issue Tracker

Our [GitHub issue tracker](https://github.com/TES5Edit/TES5Edit/issues) offers a place to submit and discuss feature requests and bug reports. When using it, please ensure that any criticism you provide is constructive.

Please do not use the tracker for general help and support on how to use xEdit.

## Releases

Check for new versions on the following pages:

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

### Current Official Threads

- [Bethesda.net](https://bethesda.net/community/topic/57570/relz-sseedit)
- [AFK Mods](https://afkmods.iguanadons.net/index.php?/topic/3750-wipz-tes5edit/)

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

If you don't already have a Delphi environment, we recommend using [Delphi 11 Community Edition](https://www.embarcadero.com/products/delphi/starter).

### Install Dependencies

- Download and install [Project Magician](https://www.uweraabe.de/Blog/downloads/download-info/project-magician/).
- Download and install [DDevExtensions](https://github.com/DelphiPraxis/DDevExtensions/releases).
- Launch Delphi and navigate to Tools &rarr; DDevExtensions Options.
- Under Extended IDE Settings, **enable** the _Disable Package Cache_ option.
- Exit Delphi.
- Clone the xEdit repo (if you haven't already) and initialize submodules (run `git submodule update --init --recursive` from the git root).
- Navigate to the _External\jcl\jcl\source\include\\_ directory and copy **jcl.template.inc** to **jcld28win32.inc**. To build xEdit 64 bit, copy **jcl.template.inc** again, to **jcld28win64.inc**
- Open _External\jcl\jcl\packages\JclPackagesD280.groupproj_.
- Build All, then install all packages (non-runtime packages with green icons).
- Restart Delphi.
- Open _External\jvcl\jvcl\packages\D28 Packages.groupproj_.
- Navigate to Tools &rarr; Options.
- Under Language &rarr; Delphi, add the below paths to the _Library_ option:
  - _{TES5Edit repo}\External\jcl\jcl\lib\d28\win32_
  - _{TES5Edit repo}\External\jcl\jcl\source\include_
- Build All, then install all packages (non-runtime packages with green icons).
- Restart Delphi.
- Navigate to Tools &rarr; Options.
- Under Language &rarr; Delphi, add the below path to the _Library_ option:
  - _{TES5Edit repo}\External\jvcl\jvcl\lib\d28\win32_
- Restart Delphi.
- Open _External\VirtualTrees\Packages\RAD Studio 11\VirtualTreeView.groupproj_.
- Build All, then install **VirtualTreesD28.bpl**.
- Open _External\FileContainer\FileContainer28.groupproj_.
- Build All, then install **FileContainerD28.bpl**.

### Important Note

If you don't have commercial [DevExpress](https://www.devexpress.com/) components, you'll need to open _BethWorkBench.groupproj_ and ensure the Build Configuration is set to `LiteDebug`.

### xEdit versions

Rename the xEdit executable based on the following table:

| Game               | Executable Name     |
|--------------------|---------------------|
| Enderal            | `EnderalEdit.exe`   |
| Enderal SE         | `EnderalSEEdit.exe` |
| Oblivion           | `TES4Edit.exe`      |
| Skyrim             | `TES5Edit.exe`      |
| Skyrim SE          | `SSEEdit.exe`       |
| Skyrim VR          | `TES5VREdit.exe`    |
| Fallout 3          | `FO3Edit.exe`       |
| Fallout: New Vegas | `FNVEdit.exe`       |
| Fallout 4          | `FO4Edit.exe`       |
| Fallout 4 VR       | `FO4VREdit.exe`     |
| Fallout 76         | `FO76Edit.exe`      |

## xEdit Updates

With each new version of xEdit, it is recommended to restore plugins from backups and reclean them. Otherwise, any fixes and updates to the cleaning process won't take effect.

### Changelog

[What's New](http://tes5edit.github.io/whatsnew.html)

The Changelog has been moved to the What's New document.
