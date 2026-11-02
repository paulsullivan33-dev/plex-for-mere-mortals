# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's media are generated clips with invented titles.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 12 names what the tool
   cannot or will not do: closed source under one vendor's
   changing terms, an account layer the product is designed
   around, remote streaming and hardware transcoding behind a
   subscription, metadata and codecs that arrive from the
   vendor's servers, a scanner that believes filenames, and a
   catalogue that is neither backup nor archive.
8. **The ethics rule is in the text, early.** Plex organises
   media; it does not ask where the media came from, so this
   guide states its own line in the README and chapter 1,
   before any procedure depends on it: build your library from
   media you have the right to keep, and share it the way you
   would lend your shelves — with your own household and people
   you know. The privacy side is stated just as early: an
   unclaimed server keeps to the local network, while a claimed
   one is a known device on an account that talks to the
   vendor's services, and the reader deserves that trade priced
   before they sign in, not after.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a 4-CPU, 7.7 GB Ubuntu 24.04
sandbox, shared with other work while the lab ran. Plex Media
Server **1.43.5.11079-b3b13e506** (official Ubuntu/Debian amd64
package, 83,265,934 bytes) was downloaded from plex.tv's own
download index; the package's SHA-1 matched the checksum Plex
publishes in that index. The sandbox has no service manager
and the guide build rules keep every write inside the lab
folder, so instead of a system install the lab unpacked the
same package (`dpkg-deb -x`) and ran the **unmodified** server
from the unpacked tree, with its support folder inside the
lab. The server ran on its genuine default port, 32400, on
loopback, and was shut down when the lab ended (t09, and again
after the t07 addendum). All transcripts live in
`plex-lab/transcripts/`; the fixture clips and their generator
are in `plex-lab/`, and the codec helper is
`plex-lab/fetch-codec.sh`.

The lab held **no Plex account**, so the server ran unclaimed
(`claimed="0"`, `myPlexSigninState="none"`) from first boot to
shutdown. That constraint turned into the guide's central
piece of evidence: everything listed as run below was done by
an unclaimed server on local requests alone.

Run for real, with transcripts as evidence:

- Download-index interrogation, package checksum verification,
  package metadata, and the full inventory of the shipped
  binaries (server, scanner, transcoder, DLNA server, tuner
  service, relay, script host) in the unpacked tree (t00).
- Fixture generation: five 5-second synthetic clips (test
  patterns plus sine tones, H.264/AAC in .mp4 and .mkv) under
  invented titles in both canonical shapes — `Title (Year)` for
  films, `Show/Season 01/Show - s01e01` for television — each
  probed with ffprobe (t01). A sixth clip, Paper Boats (2016),
  was generated mid-lab for the refresh test (t05).
- First run: cold start, ports 32400/32401 listening, the
  `/identity` document (`claimed="0"`, version string), the
  root document's fields, the empty sections list, the server
  log's first lines, and the sandbox's UDP discovery warning
  recorded as the reason automatic discovery cannot work here
  (t02).
- The web surface: `/web/` answering a 302 to
  `/web/index.html#!/setup/<machine-id>`, the 30 KB web-app
  shell fetched and identified, the empty `/myplex/account`
  document, the identifiers in `Preferences.xml`, and the
  first-run `Setup Plex.html` page (t03).
- Library creation, including the failures that teach: a
  form-encoded create refused (400); the modern
  `tv.plex.agents.movie` agent refused twice with the verbatim
  reasons ("'language' is invalid" for `en`, then "new scanner
  needs to be paired with new agent"), with `/media/providers`
  showing only the local provider on the unclaimed server; and
  success (201) with the bundled `com.plexapp.agents.imdb`
  agent and Plex Movie Scanner (t04).
- Scanning and refresh: three films catalogued with titles and
  years parsed from filenames and `local://` identifiers (no
  online record attached to the invented titles); a fourth
  film added by refresh; the first refresh's three-minute
  stall traced in the scanner log to analysis retrying an
  undownloadable codec (27 failures), and the second refresh
  adding the film in about a second once the queue drained
  (t05).
- A television library with the bundled TVDB agent and series
  scanner: one show, one season, two episodes, season/episode
  numbers parsed from `s01e01`/`s01e02`, episode titles left as
  "Episode 1"/"Episode 2" for want of an online episode list
  (t06).
- The API as a client sees it: a full item record (media,
  streams, part with its file path); the part fetched whole
  through the server with SHA-256 identical to the file on
  disk; a 1024-byte ranged fetch answering 206 with bytes
  hash-identical to the file's first kilobyte; a FriendlyName
  change via `/:/prefs` reflected in the root document and
  persisted in `Preferences.xml`; empty sessions and clients
  lists; and both libraries plus the new name intact across a
  stop/start cycle (t07 and its addendum).
- The transcoder, end to end: the photo transcoder resizing a
  server resource to 64x64; the decision endpoint refusing a
  headerless request (no client profile), then, with a
  declared Chrome client, returning decision codes 3000/1001
  with their texts; the 1 kbit/s `maxVideoBitrate` trap
  producing the verbatim "not enough bandwidth" decision; a
  start without a prior decision refused (400); decision-then-
  start issuing a session whose master playlist offers a
  160x90, 140 kbit/s variant of the 640x360 source; four
  on-demand codecs (h264_decoder, aac_decoder,
  libx264_encoder, libmp3lame_encoder) fetched by hand from
  the URLs in the server's own log, each verified against the
  SHA-1 Plex publishes for it, and installed into the expected
  `Codecs/<version>-linux-x86_64/` folder; the session then
  completing — segment `00000.ts` probed as H.264 at 160x90
  with MP3 audio, 5.02 s against the source's 640x360/AAC
  5.00 s; the session stopped politely; and, with a decoder
  finally present, item analysis producing the film's real
  640x360 poster (200, 15,571-byte JPEG) where the same
  address had answered 404 (t08).
- Failure behaviour and shutdown: a library created over a
  nonexistent folder is accepted and sits empty (the path is
  never checked); the section deleted again through the API;
  a fixture deleted from disk removed from the library by the
  next refresh under the default empty-trash setting; and a
  clean SIGTERM shutdown — port closed, zero Plex processes,
  database shutdown lines in the log (t09).

Documented only — described from Plex's documentation, not
run, and the text does not claim otherwise:

- Claiming a server and the setup wizard's interactive flow,
  including claim tokens; everything that requires a plex.tv
  account (chapter 4 states this at the line itself).
- The modern Plex Movie / Plex TV Series agents in operation:
  their pairing was refused pre-claim in the lab, so their
  matching quality is described, not measured. Likewise the
  wizard's library creation on a claimed server, and the
  online metadata (posters, summaries, cast) those agents
  return for real, catalogued works.
- Chapter 9 entire: managed users, sharing with other
  accounts, remote access and its port mapping, Plex Relay,
  and the subscription features — including the post-2025 rule
  that remote streaming needs Plex Pass or a Remote Watch
  Pass — stated as current at writing and flagged in the text
  for the reader to re-check.
- Hardware-accelerated transcoding (a Plex Pass feature
  needing a supported GPU the lab machine does not have), the
  DLNA server in operation (the sandbox permits no UDP
  discovery), the tuner service and DVR (no tuner hardware,
  account-bound), downloads and offline viewing in the apps,
  and playback inside any real client application — the lab's
  playback proof is the byte-exact serving those clients stand
  on, performed with curl.
- The neighbour tools of chapter 11, characterised from their
  own material; the series' Jellyfin and Kodi guides carry
  their own labs.
- Installing on other platforms (Windows, macOS, NAS brands,
  the Red Hat package family) and running under the system
  service manager, which the sandbox lacks; the chapter's
  install commands are the package's documented ones.

Fixtures are this guide's own and deliberately generic: six
invented titles (The Clockwork Garden, A Field Guide to
Clouds, Harbour Lights, Paper Boats, and the programme The
Walnut Street Bakery) over generated test-pattern clips — no
real footage, names, organisations or events. Nothing in the
lab was downloaded from anywhere but Plex's official index
and codec service, and every downloaded file the guide relies
on was hash-checked against its publisher's own checksum.
