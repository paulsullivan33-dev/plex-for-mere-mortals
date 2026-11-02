# Plex for Mere Mortals

You have films, programmes and music on a
hard drive, in folders with sensible
names, and playing them still means
plugging the right drive into the right
screen and hunting with a file browser.
**Plex** is the layer that tidies this
up. One program — **Plex Media Server** —
lives on the machine that holds your
files. It scans the folders you point it
at, builds a library with titles, years,
posters and episode lists, and serves
the collection to **client apps** on
your television, phone, tablet and
browser, at home or (with an account)
away from it. When a client cannot play
a file as it stands, the server converts
it on the fly — that is the
**transcoder**, and chapter 8 takes it
apart.

A word about whose media this is. Plex
is a tool for organising and playing
media you have the right to keep and
watch — your own rips, recordings and
purchases. This guide uses only
synthetic clips the lab generated
itself, wearing invented titles, and the
habit it teaches is the one to keep:
a library of your own media, shared at
most with your own household.

The lab behind this guide ran the real
server: **Plex Media Server
1.43.5.11079**, the official Ubuntu
package from plex.tv, on a small Linux
machine with no Plex account. Against
it the lab started the server from
cold, read its identity before anyone
had claimed it, built a film library
and a television library over generated
fixture clips, scanned, refreshed, and
watched a new film land. It served a
file back through the server's own
address and checked it byte for byte.
It changed the server's name through
the settings interface and watched the
change land in the server's own
preferences file. And it drove the
transcoder the way a picky client
would — asking for a decision first,
then a stream — until the server
produced a genuinely smaller,
re-encoded copy of a clip.

What the lab could not do, it did not
fake. Claiming a server — signing it
into a real plex.tv account — is an
interactive step that needs an account
this lab does not have, so claiming,
remote access, library sharing and
the paid **Plex Pass** features are
taught from the documentation and
labelled as such wherever they appear.
The lab's one big discovery cuts the
other way: an *unclaimed* server is not
a crippled one. On the local network it
scans, organises, serves and transcodes
happily, and this guide proves each of
those on the transcripts. `criteria.md`
keeps the full ledger of what was run
and what was only read.

## What this guide covers

- [**What Plex is**](what-plex-is.md) —
  the mental model: one server holding
  your files, a library built from their
  names, clients everywhere, and the
  account layer that sits on top without
  being the foundation
- [**The moving parts**](the-moving-parts.md) —
  the server program and the helpers
  shipped beside it (scanner, transcoder,
  DLNA server, tuner service), the
  support folder where its database and
  preferences live, the agents that name
  things, and the codecs it fetches as
  needed
- [**Installing Plex Media Server**](installing-plex.md) —
  the official package for your system,
  what is inside it, and the identity
  check that proves the server is up
- [**First run and claiming your server**](first-run-and-claiming.md) —
  the setup flow, what claiming means,
  what an unclaimed server can already
  do, and the honest line between the
  two
- [**Organising your files**](organising-your-files.md) —
  the naming shapes Plex reads — films
  with years, shows with seasons and
  episode numbers — because the filename
  is the message the scanner lives on
- [**Libraries and scanning**](libraries-and-scanning.md) —
  creating libraries, the two halves of
  a scan (finding files, then analysing
  them), refreshes, and what happens
  when a file disappears
- [**Watching and listening**](watching-and-listening.md) —
  the web app and the client apps, how a
  client receives a file (proven byte
  for byte), and the difference between
  direct play and being served a
  conversion
- [**The transcoder**](the-transcoder.md) —
  the decision before every stream, the
  quality caps that force a conversion,
  the on-demand codecs, and a real
  640x360-to-160x90 conversion measured
  in the lab
- [**Users, sharing and remote access**](users-sharing-and-remote-access.md) —
  accounts, managed users, sharing a
  library and watching away from home —
  the account-bound half of Plex,
  labelled documented-only where the
  lab could not go
- [**Recipes**](recipes.md) — a first
  library from a messy folder, adding a
  film the tidy way, checking the server
  from the command line, fetching a
  codec by hand, and renaming the server
- [**The neighbours**](the-neighbours.md) —
  Jellyfin the open-source twin, Kodi
  the player that is its own library,
  Emby, and the plain file share: what
  each does that Plex doesn't, and vice
  versa
- [**Limits**](limits.md) — the closed
  source, the account gravity, the
  features behind Plex Pass, the codecs
  and metadata that arrive from Plex's
  servers, and what an unclaimed server
  cannot pair with
- [**Troubleshooting**](troubleshooting.md) —
  the library that stays empty, the
  refresh that seems ignored, the
  missing posters, the conversion that
  fails on a codec, the client profile
  the server cannot find, and the traps
  this guide's lab fell into
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Setting up a television tuner and DVR —
the server ships a tuner service, but
it needs a physical tuner, an account
and a programme guide, none of which
the lab has; chapter 2 names the part
and chapter 12 is plain about the rest.
Downloading media: Plex organises and
plays what you already have, and this
guide's fixtures are five-second clips
it made itself. The Plex streaming
service itself — the free films and
channels Plex-the-company offers — is
a different product from your server
and appears here only to be told apart
from it.

## How to use this guide

Read chapter 1 for the model and
chapter 2 before installing anything —
knowing which part holds what turns
later confusion into a named problem.
Chapter 5 deserves slow reading even
if you skip ahead: most "Plex got it
wrong" stories are filename stories.
The lab's transcripts live in
`plex-lab/transcripts/`; its fixture
clips are in `plex-lab/fixtures/` with
the generator in `plex-lab/make-fixtures.sh`,
and the codec fetch the lab had to
invent is `plex-lab/fetch-codec.sh`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Jellyfin for Mere Mortals](https://paulsullivan33-dev.github.io/jellyfin-for-mere-mortals/)
- [Kodi for Mere Mortals](https://paulsullivan33-dev.github.io/kodi-for-mere-mortals/)
- [ffmpeg for Mere Mortals](https://paulsullivan33-dev.github.io/ffmpeg-for-mere-mortals/)
- [Tailscale for Mere Mortals](https://paulsullivan33-dev.github.io/tailscale-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/plex-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/plex-for-mere-mortals/blob/main/LICENSE-CODE).
