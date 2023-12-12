---
layout: post
title:  "Clearing the touch bar in macOS Sonoma"
---

In 2020 I finally bought a retina MacBook Pro.  Unfortunately it has a touch
bar.  I don't like the touch bar's functionality or illumination so I keep it
entirely blank until I press the Fn key.

Prior to macOS Sonoma I had this set up in System Settings > Keyboard > Touch
Bar Settings as follows:

![Touch Bar Settings dialog contents](/assets/Touch Bar Settings Dialog.png)

However, in macOS Sonoma, the touch bar shows "Configure in: Extensions
Settings" on startup rather than being entirely blank.

Running the following command from a terminal after startup will work around
the issue.

```bash
sudo killall -9 TouchBarServer
```

After this runs, the touch bar is blank and the Fn key brings up the expanded
control strip as expected - everything works normally.

Right now I just run this in a terminal after every (infrequent) boot.  I'll
update this post if I decide that I care enough to make this into a login item.
