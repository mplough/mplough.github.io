---
layout: post
title:  "Fixing QGIS map visibility shortcuts on macOS"
---

### Background

On macOS, QGIS assigns Cmd+Tab and Cmd+Shift+Tab as the default keyboard
shortcuts for "Toggle Panel Visibility" and "Toggle Map Only", respectively, as
I [reported in August 2023](https://github.com/qgis/QGIS/issues/54109). The
issue persists in QGIS 4.0.

![QGIS problematic shortcuts](/assets/qgis shortcuts.png)

Since macOS has always used these key combinations to switch between apps,
these shortcuts do nothing.  Although the macOS build situation for QGIS is
finally getting better, it might be a while before these shortcuts get fixed
upstream.  A fix would need to be somewhat complicated; it would either involve
overriding Qt Designer's mapping of Ctrl to Cmd on macOS specifically for these
shortcuts or creating and loading a shortcut XML file at perhaps first run?
Gross.

It's also not possible to use Settings > Keyboard Shortcuts to assign Ctrl+Tab
and Ctrl+Shift+Tab to these actions because pressing the Tab key causes focus
to move away from the "Change" item while it's listening for a key combination.
However, it's possible to save and load shortcuts as XML, so it's possible to
manually create compatible shortcuts and load them into QGIS.

### Workaround

To fix the issue:

1. <a href="/assets/qgis-fix-macos-tab-shortcuts.xml" download>Download this shortcuts XML file</a>.
1. In QGIS, open Settings > Keyboard Shortcuts.
1. Click "Load...", then load the XML file.

Now "Toggle Panel Visibility" will use Ctrl+Tab and "Toggle Map Only" will use
Ctrl+Shift+Tab.
