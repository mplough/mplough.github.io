---
layout: post
title:  "Celestron C5: Flat frames"
---

I wanted to understand how much vignetting I could expect in the best case when
taking pictures through my Celestron C5.  Known vignetting characteristics will
help me better plan both terrestrial and sky photography.  I shot flat frames
in six different configurations at three different crops, covering all possible
imaging configurations with my current collection of gear.

## Setup

I placed my Celestron C5 on a table and placed the screen of my 13-inch 2020
MacBook Pro directly against the front of the telescope.  To maintain a
consistent, known lighting source, I set the screen to the default white
balance and the maximum available brightness and pulled up a pure white test
screen.

While acquiring images I needed to support the camera assembly attached to the
rear of the telescope to prevent the unit from flipping over backwards.

![setup](/assets/vignette/setup.jpg)

I took all shots with a Nikon D750 and exposed all frames with the histogram
maximum showing about 80% to the right and no clipped highlights.

I shot raw files in FX (full frame), 1.2x, and DX (1.5x) crops in six
configurations, as outlined below.  I used Affinity Photo 1.9.2 to post-process
each shot by developing with the default settings, converting to black and
white using the default black-and-white adjustment layer, and using a levels
adjustment layer to set the white level as in the table.

|Barlow?|Reducer?|T adapter|ISO|Shutter|White level|
|-------|--------|---------|---|-------|-----------|
|No|No|Universal|100|1/2.5|83%|
|No|No|SC|100|1/2.5|85%|
|No|**Yes**|Universal|100|1/5|81%|
|No|**Yes**|SC|100|1/5|84%|
|**Yes**|No|Universal|100|2”|74%|
|**Yes**|**Yes**|Universal|100|1.3”|74%|

* **Reducer** - Celestron #94175 0.63x reducer/corrector
* **Barlow** - Meade Series 4000 #126 short-focus Barlow
* **Universal T-adapter** - Celestron #93625 1.25" universal T-adapter in a
  Celestron #93653-A 1-1/4 inch visual back
* **SC T-adapter** - Celestron #93633-A T-adapter for Schmidt-Cassegrain telescopes

I used a Celestron #93402 T-ring for Nikon to attach each T-adapter to the
camera.

## Results

The universal T adapter vignettes significantly in full frame.  It's simply not
wide enough to pass all the light gathered by the telescope.  However, it's
incredibly convenient for rapid switching between visual accessories and an
imaging stack for both terrestrial and casual sky photography.  Unlike the
screw-on T-adapter, it can also hold a Barlow lens.  Its vignetting performance
with a Barlow installed is far more reasonable.

A 2-inch visual back and a 2-inch camera nosepiece are in my future. These
tools will offer convenient accessory switching, better light passage, and
improved collimation and stability, albeit at the cost of increased weight.

The reducer makes the scope 1 1/3 stops faster, allowing for shorter exposure
times, but it does not appreciably widen the maximum usable field of view.  In
fact, it becomes necessary to shoot in DX mode because the image edges are
totally black.  This relationship is not surprising; the edges are nearly black
in the full frame shot without the reducer, so no more light is available at
the edges of the frame.  The reducer then increases the maximum field of view
past the black edges by a factor of 1/0.63, which is very nearly the reciprocal
of a 1.5x DX crop.

A table of vignettes is presented below.

|B?|R?|T|FX|1.2x|DX|
|-------|--------|---------|--|----|--|
|No|No|U|![vignette](/assets/vignette/U-nR-nB-FX.jpg)|![vignette](/assets/vignette/U-nR-nB-1p2x.jpg)|![vignette](/assets/vignette/U-nR-nB-DX.jpg)|
|No|No|SC|![vignette](/assets/vignette/SC-nR-nB-FX.jpg)|![vignette](/assets/vignette/SC-nR-nB-1p2x.jpg)|![vignette](/assets/vignette/SC-nR-nB-DX.jpg)|
|No|**Yes**|U|![vignette](/assets/vignette/U-yR-nB-FX.jpg)|![vignette](/assets/vignette/U-yR-nB-1p2x.jpg)|![vignette](/assets/vignette/U-yR-nB-DX.jpg)|
|No|**Yes**|SC|![vignette](/assets/vignette/SC-yR-nB-FX.jpg)|![vignette](/assets/vignette/SC-yR-nB-1p2x.jpg)|![vignette](/assets/vignette/SC-yR-nB-DX.jpg)|
|**Yes**|No|U|![vignette](/assets/vignette/U-nR-yB-FX.jpg)|![vignette](/assets/vignette/U-nR-yB-1p2x.jpg)|![vignette](/assets/vignette/U-nR-yB-DX.jpg)|
|**Yes**|**Yes**|U|![vignette](/assets/vignette/U-yR-yB-FX.jpg)|![vignette](/assets/vignette/U-yR-yB-1p2x.jpg)|![vignette](/assets/vignette/U-yR-yB-DX.jpg)|
