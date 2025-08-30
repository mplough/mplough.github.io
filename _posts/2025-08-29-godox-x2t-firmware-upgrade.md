---
layout: post
title:  "Godox X2T-N firmware upgrade notes"
---

Upgrading the firmware on my Godox X2T-N flash controller was quick but a little more
complicated than I anticipated.

The upgrade requires running a firmware upgrade program.  The X2T-N v1.4
instructions instructions said to use Godox G3 MacOS v1.1 but v1.1 is
Windows-only.  I grabbed Godox G3 v2.0 for macOS from Godox's [firmware
launcher installer download
page](https://www.godox.com/firmware-launcher-installers/) and that ended up
working fine.

I also ran into issues with connecting the controller to my computer.  I needed
to connect my computer to my monitor (which acts as a USB hub) and connect the
X2T-N to the monitor with a USB-A to USB-C cable.  Connecting directly with a
USB-C to USB-C cable did not work.  I learned this trick from
[Careless_Sun2442](https://www.reddit.com/user/Careless_Sun2442/) on
[Reddit](https://old.reddit.com/r/Godox/comments/wdyoxr/anyone_able_to_update_firmware_with_macbook_pro/l22vyse/):

> I also had the same problem when trying to update all my Godox flashes V1s
> and N350s, and the XPro IIs using my Macbook Pro M2. At first I thought it
> was the faulty USB-C cable but when I tried using a few other USB-C cables, I
> also encountered the same issue which was not recognising any of my devices
> when I plug it in my USB-C port. So I took an Alogic Hub which I plug into my
> Macbook Pro USB-C and then I plug the cable from my Godox devices to the
> Alogic Hub and it magically recognised the device which allowed me to update
> all the firmware of all my devices successfully. So if you still have any
> such issue, please try using a Hub as an intermediary for your connection
> which may work for you too.

The firmware can be upgraded with the X2T-N off and the batteries removed.

Godox G3 can download and install firmware with no need to download firmware
binaries separately.
