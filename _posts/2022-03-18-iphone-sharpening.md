---
layout: post
title:  "iPhone 13 Pro over-sharpening"
---

The iPhone 13 Pro's camera application over-sharpens photos during
post-processing.  As a result, photos taken with the best smartphone camera
hardware available end up looking like they belong next to a RealPlayer embed
on some Tripod site from 1999.  The over-sharpening occurs whether shooting
HEIF or ProRAW.  With HEIF the over-sharpening is unrecoverable.  With ProRAW,
however, it is possible to defeat the over-sharpening by performing a null edit
on the image in the Photos app on the phone.

To illustrate the severity of the issue and the possibility of defeating it, I
took three pictures of my 2020 13-inch MacBook Pro screen displaying
[apple.com](https://www.apple.com/) on the evening of March 18, 2022.  The
pictures look slightly orange because my screen is slightly orange; I use
[f.lux](https://justgetflux.com/) to lower the display's color temperature at
night.

I took these using the "3x" zoom setting from roughly the distance of the
laptop's lower case.  Since the 3x camera hardware cannot focus that close, the
phone uses the 1x camera and digitally zooms in.  This digital zoom actually
looks fine once the over-sharpening is defeated.

A screenshot of the web site:

![apple site](/assets/2022-03-18 - apple.com.png)

An over-sharpened HEIF, converted to JPEG.  Notice the weird ringing around the
black text as well as the loss of color in the links:

![oversharpened HEIF](/assets/2022-03-18 - apple.com oversharpened heif.jpeg)

An over-sharpened ProRAW, converted to JPEG.  The ringing and loss of color are identical:

![oversharpened ProRAW](/assets/2022-03-18 - apple.com oversharpened proraw.jpeg)

A ProRAW that looks decent, converted to JPEG.  The ringing is gone and the
links show up in a nice blue:

![decent ProRAW](/assets/2022-03-18 - apple.com decent proraw.jpeg)

Tap or click to compare the oversharpened and decent ProRAW images:

<script type="text/javascript">
    var toggle = false;
    function toggle_image(image) {
        let image_1 = "/assets/2022-03-18 - apple.com oversharpened proraw.jpeg";
        let image_2 = "/assets/2022-03-18 - apple.com decent proraw.jpeg";
        if (toggle) {
            image.src = image_1;
        }
        else {
            image.src = image_2;
        }
        toggle = !toggle;
    }
</script>
<img alt="Oversharpened vs. decent ProRAW"
     src="/assets/2022-03-18 - apple.com oversharpened proraw.jpeg"
     onclick="toggle_image(this)" 
/>

In order to defeat the over-sharpening, I performed a null edit as follows:

1. Take the photo.
1. Open the Photos app on the phone.
1. Tap "Edit".
1. Tap "Exposure".
1. Drag the slider off of zero and then back to zero.
1. Tap "Done".

It's also possible to defeat the over-sharpening by allowing the photo to sync
from the phone to a computer via iCloud Photos, and then perform a similar null
edit in Photos on the computer.

This deficiency is exasperating.  I bought an iPhone 13 Pro so that I'd have an
excellent camera on me at all times, but instead I'm writing detailed bug
reports in the futile hope that some Apple engineer cares enough to make their
computational photography look better than a Kodak Instamatic shooting [110
film](https://en.wikipedia.org/wiki/110_film).
