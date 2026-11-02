# Limits

**Outcome: the bill, itemised — what
Plex cannot do, what it will not do
without an account or a subscription,
and what it depends on that you do
not control.** None of these ended
the lab's work; all of them should
surprise nobody who has read this far.

## Closed source, one vendor

The server is free of charge, not
free software. You cannot read it,
patch it, or keep it if the company
changes its mind about the terms —
and the terms do move: features have
migrated behind Plex Pass over the
years, and the 2025 change that put
remote streaming behind a pass (or a
watch pass) is the standing example.
The database format, the agents and
the clients are all Plex's. Your
files remain stubbornly yours — the
fixtures on disk are untouched
ordinary files, and chapter 11's
neighbours will adopt the same
folders tomorrow — but the catalogue
built over them does not export into
anyone else's shape.

## Account gravity

The product is designed around the
signed-in state. The setup flow leads
with an account; the modern metadata
agents wait behind claiming (the lab
hit this in transcript `t04`); the
apps assume sign-in; remote access,
sharing and managed households all
hang from the account. An unclaimed
server is a real, working thing —
this guide proved its week — but it
is plainly the side door, and some
rooms off it stay locked.

## The paywall's actual fence

Plex Pass, at the time of writing,
carries: hardware-accelerated
transcoding; downloads into the
mobile and desktop apps for offline
viewing; the DVR and guide features
of the tuner service; remote
streaming in combination with the
rule of chapter 9 (or a Remote Watch
Pass on the viewer's side); and
assorted refinements. Local-network
playing, libraries, scanning, and
software transcoding are not behind
it. Prices and the exact fence move;
the shape — polish and reach for
money, the local core for free — has
been stable.

## It phones home, by design

Three dependencies on Plex's
infrastructure survived even the
lab's offline-ish run. **Codecs** are
fetched on first use (chapter 8): a
server born on a sealed network can
scan and serve but cannot convert,
and cannot even make posters, until
they arrive. **Metadata** for the
modern agents is aggregated by Plex's
service — superb matching, and
another conversation your server has
with the company. **Updates, account
services and the relay** speak for
themselves. Add the telemetry and
privacy settings of chapter 9, and
the fair summary is: Plex is a local
server with a cloud accent that
deepens the more of it you use.

## Smaller, harder edges

- **The scanner believes filenames.**
  Chapter 5's grammar is a contract:
  meet it and matching is near-magic;
  miss it and items merge, split or
  vanish, with the fix always a
  rename rather than a setting.
- **Deletion is real.** A missing
  file plus a refresh plus the
  default trash setting removes the
  item and its metadata (transcript
  `t09`). Plex is a catalogue, not a
  backup, and not an archive.
- **Libraries do not check paths.**
  A library can point at a folder
  that does not exist and sit empty
  without complaint (transcript
  `t09`) — configuration errors are
  silent by default.
- **One server, one database.** The
  design centre is a household, not a
  federation: no supported way to run
  two servers as one library, or to
  merge catalogues.
- **The tuner half is hardware-bound.**
  The DVR exists on paper in chapter
  2 and needs a physical tuner, an
  account and a guide subscription
  territory the lab could not enter.

## The check that keeps you honest

```bash
curl -s http://127.0.0.1:32400/identity
```

`claimed`, `version`, and the machine
identifier: the three facts from
which most of this chapter follows.
Know which side of `claimed="0"` your
server lives on, and none of the
limits above can ambush you.
