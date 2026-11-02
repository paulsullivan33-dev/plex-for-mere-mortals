# The Transcoder

**Outcome: you can explain — and, on
your own server, watch — the two-step
every converted stream goes through:
a decision, then a conversion, with
the codecs arriving as needed.** This
is the chapter the lab's sandbox
fought hardest, and the fight is the
teaching: transcript `t08` is the
whole campaign.

## Step one: the decision

Before any conversion starts, the
client asks the server to *decide*.
The request names the item, the part,
how the client intends to play
(direct play allowed? a bitrate cap?)
and — crucially — **who is asking**:
a set of headers identifying the
client, which the server matches
against its bundled **client profiles**
(`Resources/Profiles/`, one XML per
family of device: Chrome, Firefox,
and dozens of televisions and sticks).
No matching profile, no decision: the
lab's first, headerless attempt was
refused with exactly that explanation
in the log.

A decision answers in codes, and the
lab's forced example is a clean read:

```text
directPlayDecisionCode  3000
  "App cannot direct play this item. Direct play is disabled."
generalDecisionCode     1001
  "Direct play not available; Conversion OK."
transcodeDecisionCode   1001
  "Direct play not available; Conversion OK."
```

Direct play had been switched off in
the request and a bitrate cap set
below the file's own rate, so the
server agreed to convert. In ordinary
life the same machinery quietly
produces the other answers: direct
play (send the file), or **direct
stream** (repackage the same picture
and sound into a container the client
prefers — cheap, because nothing is
re-encoded). The viewer's only real
input is the app's quality setting;
chapter 7 names the lever.

Two traps from the transcript, worth
learning here: `maxVideoBitrate` is
in **kbit/s** — ask for 1 and the
decision is legitimately "not enough
bandwidth for any playback of this
item" — and a stream must be
**started only after its decision**:
a start request for a session nobody
decided is refused with a bare 400.

## Step two: the conversion

A started session is a small,
temporary television station. The
start answer is a playlist:

```text
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=140000,
  RESOLUTION=160x90,FRAME-RATE=24
session/<id>/base/index.m3u8
```

That is the server honouring the
200 kbit/s cap the lab imposed: the
640x360 film is offered as a 160x90
stream at 140 kbit/s. Inside the
session, the **Plex Transcoder**
process converts the file in slices
(a few seconds each) and the client
fetches the playlist, then the
segments, as it plays; the session's
folder under `Cache/Transcode/Sessions/`
lives exactly as long as the viewing.
The lab fetched the playlist and its
one segment, and measured the goods:

```text
segment 00000.ts — 129,908 bytes, 5.02 s
  video: h264, 160x90     (source: h264, 640x360)
  audio: mp3              (source: aac)
```

A conversion in fact, not in name:
smaller picture, re-encoded audio,
same five seconds.

## The codecs under the floorboards

Why the campaign took a campaign: the
transcoder does not carry every codec
it may need. Decoders and encoders
are fetched, once, from Plex's servers
(chapter 2). The sandbox refused the
server's own requests, so sessions
died at configuration with an honest
log trail — decoder `h264` first,
then `aac`, then the `libx264`
encoder, then `libmp3lame` for the
audio — each failure naming the next
missing piece. The lab fetched each
by hand, **checking every file against
the SHA-1 Plex itself publishes** for
it, and dropped it in the folder the
server expects (`plex-lab/fetch-codec.sh`
is the recipe). Four codecs later the
segment above played. On an ordinary
network the server does this silently
on first use; the lab notes it because
an offline or filtered network is
precisely where a reader would meet
the same wall, and now its shape —
and its remedy — are on the record.

## What it costs, and the paid shortcut

Transcoding is the server's heaviest
work: it is re-encoding video in real
time, on your hardware, per viewer.
A modern desktop CPU handles a stream
or two of modest size; high-resolution
sources multiply the bill. The
settings that govern it live under
the server's Transcoder settings —
a quality preference (favour speed or
favour quality), a temporary folder,
and how much to convert ahead. The
escape hatch is **hardware
acceleration**: handing the work to a
graphics processor's dedicated video
circuits. On this platform that
feature sits behind Plex Pass
(chapter 9), and it needs a supported
GPU; the lab's machine has neither,
so it is documented-only here — named,
priced in chapter 12, and not once
pretended at.
