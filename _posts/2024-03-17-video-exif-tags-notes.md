---
layout: post
title:  "Working notes on EXIF tags for video files"
---

I store my processed photos and videos in Apple Photos so I can view them from
anywhere on my phone or computer.  Viewing media in chronological order is
fundamental but I'd like to have other metadata available if at all possible.
That's possible for images but EXIF data for video is a mess as far as I can
tell from reading scattered forum posts.  I'd love to be able to cite some
sources on this; please let me know if there is an authoritative source for
this information.

Apple Photos parses dates inside video files but doesn't seem to parse
location, camera, or lens metadata.  However, it does store original files in a
recoverable fashion, so if I ensure that all metadata is included in video
files, there is a chance that Apple Photos (or some other application) will be
able to read that metadata in the future.

As verified by experiment, [Exiftool](https://exiftool.org/) 12.76[^1] (and likely
greater versions) can read and write metadata from MOV and MP4 video files.
MOV files are [QuickTime
containers](https://en.wikipedia.org/wiki/QuickTime_File_Format) while MP4
files are [MPEG-4 containers](https://en.wikipedia.org/wiki/MPEG-4).

EXIF data in video files is generally [QuickTime tags](https://exiftool.org/TagNames/QuickTime.html).

I use [Handbrake](https://handbrake.fr/) and other tools to compress processed
video to maximize space efficiency.

The situation:

* DSLR and mirrorless cameras write metadata to video files that they create.
  Apple Photos does not parse this metadata.
* Exiftool reads metadata just fine from camera video files.
* Various [ffmpeg](https://ffmpeg.org/) and `ffprobe` incantations didn't
  demonstrate an ability to read metadata from camera video files.  Maybe this
  is possible but if it is, it's not easy and it's not documented in a way
  that's discoverable by even expert software programmers.
* Apple Photos does not read metadata (apart from timestamps) in either MOV or
  MP4 containers.
* Handbrake can get video files down to much more reasonable sizes while
  keeping decent quality, especially when writing H.265, but it doesn't pass
  through EXIF data such as camera make, model, lens, or timestamps.
* A trial of [ffworks](https://www.ffworks.net/) showed that it didn't pass through metadata either.
* Handbrake can only output MP4 containers while fftools can also output MOV
  containers (due to underlying ffmpeg support for both container formats).

To at least retain video metadata, do the following:

After compressing with Handbrake, use Exiftool to copy tags from the source file to the output file:

```bash
exiftool -all= -tagsfromfile [source] -all [output]
```

Use Exiftool to geotag a video - [HoudahGeo](https://www.houdah.com/houdahGeo/) can't geotag video files.

Either copy location tags from a source image...
```bash
exiftool -tagsfromfile [source] -location:all [output]
```

...or write the location tags explicitly.

```bash
exiftool -GPSLatitude=[decimal degrees] -GPSLatitudeRef=[N|S] -GPSLongitude=[decimal degrees] -GPSLongitudeRef=[E|W]
```

The ffworks tool does have some nice GUI display of video quality metrics,
which may prove useful for quick evaluation of quality loss when recompressing.


[^1]: Exiftool has weird nonstandard command-line arguments.  Get the version of Exiftool by running `exiftool -ver`.
