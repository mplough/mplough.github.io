---
layout: post
title:  "Digilent WaveForms and macOS app entitlements"
---

## The short version

[Digilent](https://digilent.com/) makes a line of oscilloscopes that use a free application called
[WaveForms](https://digilent.com/reference/software/waveforms/waveforms-3/start)
for control.  WaveForms can also use any sound card or microphone as an
oscilloscope input, albeit one without a calibrated voltage scale.

As snooping via the microphone is a privacy risk, modern operating systems
require that applications request permission to use the microphone.  The
mechanism for doing so isn't simple and a few months ago I discovered an
issue with the WaveForms application where attempting to use the sound card as
an input would result in no signal being acquired.  I [reported the
issue](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.device.audio-input)
and to my surprise and delight, a real person replied less than three hours
later thanking me for my report and saying that the issue had already been
fixed in the latest beta.  Kudos to Digilent's support team.

## How I diagnosed the issue

On macOS, capabilities are requested via
[entitlements](https://developer.apple.com/documentation/bundleresources/entitlements).
For example, the entitlement for use of the microphone in a sandboxed
application is called
[com.apple.security.device.microphone](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.device.microphone).
There is a similar entitlement for hardened applications called
[com.apple.security.device.audio-input](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.security.device.audio-input).
It's especially confusing how the names imply similar if not completely
redundant intents for both entitlements and reveal nothing about the different
contexts (sandbox vs. hardened) in which they should be requested.

Back to that signal in WaveForms.

I suspected that something was wrong when I didn't see a prompt asking if
WaveForms could use the microphone.  As someone who doesn't write native Mac
apps, I needed to do some digging to learn how entitlements worked, but found
that I could check the app's current entitlements by running:

```console
$ codesign --display --entitlements - /Applications/WaveForms.app/
Executable=/Applications/WaveForms.app/Contents/MacOS/WaveForms
[Dict]
	[Key] com.apple.security.cs.allow-jit
	[Value]
		[Bool] true
	[Key] com.apple.security.cs.allow-unsigned-executable-memory
	[Value]
		[Bool] true
	[Key] com.apple.security.cs.disable-executable-page-protection
	[Value]
		[Bool] true
	[Key] com.apple.security.cs.disable-library-validation
	[Value]
		[Bool] true
```

It was clear at this point that the `com.apple.security.device.microphone`
entitlement was missing and if I were an experienced Mac developer, I would
have been confident enough to make a report.  I dug further though; not only am
I not an experienced Mac developer, I also wanted to see if I could fix things
quickly myself as I was not yet aware of the Digilent support team's skill and
responsiveness.

I created the list of entitlements that the app should have, which entailed
translating the output of `codesign` to XML and adding the microphone
permission.  The resulting `entitlements.plist` contained:


```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.cs.allow-jit</key>
    <true/>
    <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
    <true/>
    <key>com.apple.security.cs.disable-executable-page-protection</key>
    <true/>
    <key>com.apple.security.cs.disable-library-validation</key>
    <true/>
    <key>com.apple.security.device.microphone</key>
    <true/>
</dict>
</plist>
```

I [created a self-signed
certificate](https://support.apple.com/guide/keychain-access/create-self-signed-certificates-kyca8916/mac)
in Keychain Access, made a copy of the app, and used the certificate and my
entitlements file to sign the copy with the missing entitlement added:

```bash
codesign -f \
    --sign "My Code Signing Certificate" \
    --entitlements entitlements.plist \
    --force-library-entitlements \
    WaveForms\ copy.app/
```

When I ran the new copy and selected the microphone, I got a prompt asking for
permission to use it and the app worked as it should.  At that point I knew
I could submit a report.

I played with permissions a few times by using
[tccutil](https://eclecticlight.co/2020/01/28/a-guide-to-catalinas-privacy-protection-4-tccutil/),
a command-line utility can reset permissions that have been previously granted.
Here I only wanted to reset permissions granted to WaveForms, so I needed the
app's bundle identifier.  There are a number of ways to [get the bundle
identifier](https://stackoverflow.com/questions/39464668/how-to-get-bundle-id-of-mac-application)
but I ended up finding `com.digilent.waveforms` in the `CFBundleIdentifier` key
inside `WaveForms.app/Contents/Info.plist` quickly enough that I didn't bother
to investigate any other method.  Running `osascript -e 'id of
WaveForms'` would have been quicker but that would have required knowing first
that macOS's Open Scripting Architecture even exists and second, how to use it.
To reset WaveForms's microphone permissions, I ran:

```bash
tccutil reset Microphone com.digilent.waveforms
```
