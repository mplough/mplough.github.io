---
layout: post
title:  "Audio glitches in Logic Pro 10.5 Live Loops"
---

On May 12, 2020, Apple released Logic Pro 10.5, calling it ["the biggest update
to Logic since the launch of Logic Pro X."](https://www.apple.com/newsroom/2020/05/apple-unveils-biggest-update-to-logic-since-the-launch-of-logic-pro-x/)
Its major new feature, Live Loops, competes with [Ableton
Live](https://www.ableton.com/en/live/).

However, the Live Loops feature in version 10.5.0 does not handle audio loop
transitions correctly.  When loops are recorded from an audio interface and
then played back, Logic introduces a click/pop audio glitch on the transition
from the end of a loop to the beginning of another loop.  Ableton Live 10 Lite
10.1.14 does not.

To show that the issue can be reliably reproduced in Logic when it is absent
from Ableton Live, I recorded a set of samples in Ableton Live and then
imported them into Logic.  I then recorded the same minimal performance
including one loop transition in each program and exported the files to WAV.

The performances follow.  The loop transition occurs at approximately 12.8
seconds.

* [Ableton performance (good)](/assets/Let It Be - Ableton Live Lite - good.wav)
* [Logic performance (bad)](/assets/Let It Be - Logic - bad.wav)

This issue is a show stopper for using Logic with ad hoc samples.
