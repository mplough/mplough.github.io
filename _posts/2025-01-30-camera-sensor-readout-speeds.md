---
layout: post
title:  "Measuring camera sensor readout speeds"
---

I measured the sensor readout speeds of a Z50, Z50II, and Z8 when shooting
photographs with electronic shutter.

I did this because I haven't seen any information online about the Z50II's
sensor readout speed.  I found that it's exactly the same as the Z30 and Z50,
about 1/22 second.  Interestingly, Thom Hogan, my go-to reviewer for Nikon,
seems to have the wrong readout time listed for the Z50 on [his sensor read-out
speeds page](https://www.zsystemuser.com/z-mount-cameras/z-camera-articles/sensor-read-out-speeds.html).

I used an Arduino Uno R3 and the technique from
<https://github.com/horshack-dpreview/RollingShutter> with slightly modified
hardware and source code.  Instead of blinking the onboard LED, which is kind
of dim, I blinked a discrete LED connected to pin 3.  The LED's dome focuses
the light, yielding a much more reasonable exposure.

I photographed a 500 Hz LED with a 105mm macro lens at 1/4000, f/2.8, ISO
12800, and sanity checked its blink rate by calibrating using the Z8, which has
a widely known readout speed of about 1/270 second.  These are the photos from
each camera - the Z50, then the Z50II, then the Z8.  It's neat to have such a
stark visual representation of how much faster a stacked sensor is read.

<figure>
    <img alt="Z50 sensor readout" src="/assets/z50-readout.jpg">
    <center><figcaption>Z50 readout image</figcaption></center>
</figure>

<figure>
    <img alt="Z50II sensor readout" src="/assets/z50ii-readout.jpg">
    <center><figcaption>Z50II readout image</figcaption></center>
</figure>

<figure>
    <img alt="Z8 sensor readout" src="/assets/z8-readout.jpg">
    <center><figcaption>Z8 readout image</figcaption></center>
</figure>
