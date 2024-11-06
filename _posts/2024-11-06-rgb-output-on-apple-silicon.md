---
layout: post
title:  "Forcing RGB output on an external monitor from an Apple Silicon machine"
---

My Dell U2720Q monitor will start flickering when used with an Apple Silicon
Mac and certain patterns are displayed on the screen.  Colors also look
slightly weird compared with how my old Intel Mac drove the display.  This
happens because by default, Intel Macs output
[RGB](https://en.wikipedia.org/wiki/RGB_color_model) color to external displays
while Apple Silicon Macs output [YPbPr](https://en.wikipedia.org/wiki/YPbPr).

On macOS Sonoma, I was able to use the code at
https://github.com/dangh/force-rgb.fish to force RGB output.  I cloned the
repository to https://github.com/mplough/force-rgb.fish in case the original is
deleted.  However, this method does not work on Sequoia 15.1 as of commit
[79a3128796f3738e3e3f09d7d39609650aad9c3c](https://github.com/dangh/force-rgb.fish/commit/79a3128796f3738e3e3f09d7d39609650aad9c3c).  The plist files are updated properly but the display reports YPbPr mode after a logout and a reboot.

On macOS Sequoia, [BetterDisplay Pro](https://betterdisplay.pro/) works.  It
makes an external monitor's color modes selectable, allowing selection of an
RGB mode:

![BetterDisplay U2720Q color modes](/assets/BetterDisplay U2720Q color modes.png){: width="272" }
