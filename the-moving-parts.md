# The Moving Parts

**Outcome: given any Plex behaviour —
a film appearing, a poster missing, a
stream stuttering — you can name the
part responsible.** The server looks
like one program in a process list. It
is a small company of them, all shipped
in the same package.

## The server and its helpers

Unpacking the official package
(transcript `t00`) shows the whole
cast in one folder:

- **Plex Media Server** — the parent
  program. It serves the web app and
  the **API** (the addressable surface
  this guide's lab used throughout) on
  port **32400**, owns the library
  database, and starts and supervises
  everything below.
- **Plex Media Scanner** — the census
  taker. It walks the folders a library
  points at, reads filenames, probes
  files with an embedded media library,
  and writes down what it finds. When
  you add a film and refresh, this is
  the process that goes to look
  (transcript `t05`).
- **Plex Transcoder** — the converter:
  the server's own build of the ffmpeg
  idea, started per stream when a
  client needs a file changed.
  Chapter 8 is its biography.
- **Plex DLNA Server** — a second,
  older-protocol front door that offers
  the library to DLNA players (some
  televisions and consoles) that speak
  nothing newer. It runs alongside; the
  lab's sandbox blocked the network
  discovery it relies on, so it is
  named here but was not exercised.
- **Plex Tuner Service** — the doorway
  for television tuners and DVR
  recording. It needs hardware the lab
  does not have, and an account; this
  guide names it and goes no further.
- **Plex Script Host** and the
  **plug-in** processes — the runtime
  for the bundled agents and system
  bundles. In the lab's process list
  you can see one per agent:
  `com.plexapp.system`,
  `com.plexapp.agents.thetvdb`,
  `com.plexapp.agents.imdb`,
  `com.plexapp.agents.localmedia`.
- **Plex Relay** — a helper for remote
  access: when a client away from home
  cannot reach your server directly,
  traffic can be relayed through
  Plex's servers. Account territory;
  documented-only here.
- **Plex SQLite** — a bundled copy of
  the database tool, matched to the
  server's own database format, for
  repair and inspection work.

## The support folder

Everything the server knows lives in
one **support folder** (on Linux,
`/var/lib/plexmediaserver/Library/
Application Support/Plex Media Server`
for a normal install; the lab pointed
it inside its own workspace). Inside:

- `com.plexapp.plugins.library.db` —
  the library itself: every section,
  item, file path and viewing state.
  This file is the crown jewel; back
  it up and the library can be rebuilt
  around it.
- `Preferences.xml` — the server's
  settings as plain attributes. The
  lab renamed the server through the
  API and watched `FriendlyName="Plex
  Lab"` appear in this file
  (transcript `t07`).
- `Logs/` — one log per part
  (`Plex Media Server.log`,
  `Plex Media Scanner.log`, and more).
  Nearly every answer in chapter 13
  starts in one of these.
- `Metadata/` and `Media/` — the
  posters, artwork and bundles the
  agents fetch or the analysis
  generates, organised by hash rather
  than by title.
- `Cache/Transcode/Sessions/` — one
  folder per live conversion, cleaned
  away when the session ends
  (chapter 8 watched them come and go).
- `Codecs/` — the on-demand codecs,
  next section but one.

## Libraries, sections, agents, scanners

A **library** (the API calls it a
**section**) is one promise: *this
folder tree, of this kind of thing —
movies, shows, music, photos — read
this way.* Two settings define how it
is read:

- The **scanner** walks and parses.
  Its grammar is chapter 5: folder
  shapes and filename shapes in,
  titles and episode numbers out.
- The **agent** names and decorates.
  Given a parsed title and year, the
  agent looks the work up — in Plex's
  online metadata, for the modern
  agents — and brings back posters,
  summaries and cast. An item no agent
  matched carries a `local://`
  identifier, Plex's way of saying
  "known only by what the file told
  us". Every lab fixture wears one,
  because invented films are in no
  one's catalogue (transcript `t05`).

One pairing rule from the lab is
worth learning here rather than in
chapter 13: the modern agents are
delivered through an online provider
that activates when the server is
claimed, so on an unclaimed server the
library-creation step pairs the
scanner with one of the bundled
agents instead (transcript `t04`).
Claimed servers use the modern agents
by default; the bundled ones remain
as the local fallback.

## Codecs that arrive as needed

The package does not contain every
codec it can use. Some — the H.264
decoder was the lab's first — are
fetched from Plex's servers the first
time analysis or transcoding needs
them, into `Codecs/<version>-linux-x86_64/`,
and then kept. Chapter 8 tells the
full story, including fetching one by
hand with its publisher's hash as the
receipt. The design is reasonable —
most installs need few, once, on an
open network — but it means a brand
new server on a sealed network can
scan and serve yet be unable to
convert or make posters until the
codecs arrive. Chapter 12 counts this
among the honest limits.

## The check

```bash
curl -s http://127.0.0.1:32400/library/sections
```

On the lab server this lists two
sections — Movies and TV — with their
agents, scanners and folder paths: the
whole cast, accounted for in one
response.
