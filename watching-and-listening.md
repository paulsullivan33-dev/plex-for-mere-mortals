# Watching and Listening

**Outcome: you know what a client
actually receives when you press play,
and can prove the simplest case — the
server handing over the file itself —
with one command.** Playback is where
every earlier chapter cashes out: the
library offers, the client chooses,
the server serves.

## The doors in

There are three, and they all open
onto the same library:

- **The web app**, served by the
  server itself at `:32400/web/` — the
  one the lab verified (transcript
  `t03`). No separate download, nothing
  loaded from plex.tv; the shell page
  arrives from your own machine and
  then talks to the API like any other
  client. This is also where settings
  and library management live.
- **The client apps** for televisions,
  phones, tablets, streaming sticks,
  consoles and desktop systems. These
  are plex.tv downloads, signed in to
  an account (or finding a local server
  on the home network), and they are
  where most watching happens.
- **The API itself**, which is not a
  door Plex advertises to viewers but
  is the door every other door uses.
  The lab walked through it for the
  whole guide, and this chapter's
  proof uses it directly.

Music and photos ride the same rails:
a music library serves albums to the
same apps (and to Plex's dedicated
music app), and photo libraries serve
their albums likewise. The lab built
film and television libraries; the
serving proof below is a film's, and
the shape of it does not change with
the media type.

## What press-play sends

Every item's record holds one or more
**parts** — the actual files, with an
address inside the server. The lab's
film (transcript `t07`):

```text
Part: id=6  size=312098
key=/library/parts/6/1793632830/file.mp4
file=/…/movies/The Clockwork Garden (2021)/
     The Clockwork Garden (2021).mp4
```

Ask for that address and the server
hands over the media — this is
**direct play** in its purest form,
the file untouched. The lab took the
whole file this way and compared
fingerprints:

```bash
curl -s "http://127.0.0.1:32400/library/parts/6/1793632830/file.mp4" \
  -o served-by-plex.mp4
sha256sum served-by-plex.mp4 "The Clockwork Garden (2021).mp4"
# 6f51ab5a…f880da8f  served-by-plex.mp4
# 6f51ab5a…f880da8f  The Clockwork Garden (2021).mp4 — identical
```

A real client does the same thing in
slices, asking for byte ranges as it
plays, and the server obliges. Nothing
is re-encoded, nothing is degraded:
if your client and your file agree,
Plex is a very organised file server.

When they do not agree — the client
cannot decode the format, or its
connection cannot carry the file's
bitrate — the client and server hold
the conversation chapter 8 dissects:
a **decision** (can it direct-play?
can it at least direct-*stream*, with
the container repackaged but the
picture untouched?) and, failing
both, a **transcode**. As a viewer
you choose almost none of this
directly; you choose the client and
its quality setting, and the decision
follows. The one lever worth knowing
by name lives in each app's settings:
a **quality cap** (a maximum bitrate
for remote playing, or "convert
automatically"). Lower it and you are
asking the transcoder to work; the
server log will show the decision it
reached, in the same words transcript
`t08` quotes.

## The honest edges of this chapter

The lab's playback proof is a file
fetched whole over loopback. It did
not press play in a television app —
there is no television, no account,
and no client device in the sandbox —
so app behaviour, casting, downloads
for offline viewing inside apps, and
synchronised group watching are
described from Plex's documentation
in chapters 9 and 11, not from a
screen the lab saw. What the lab can
certify is the thing those features
all stand on: the server serves the
right bytes, to an address per file,
on request.

## The check

From any machine that can reach the
server, pick a part key from an item
(as in transcript `t07`) and fetch a
slice of it:

```bash
curl -s -r 0-1023 \
  "http://<server>:32400/library/parts/6/…/file.mp4" \
  -o /dev/null -w "%{http_code} %{size_download}\n"
# 206 1024 — a partial serving, exactly as a player asks for it
```

A 206 and a kilobyte back: your
server serves. (On a claimed server
away from the local network, expect
the same request to ask for the
account's token first — chapter 9's
territory.)
