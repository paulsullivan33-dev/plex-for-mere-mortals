# Glossary

**Agent** — the library component
that names and decorates an item:
given the scanner's parse (a title, a
year), it looks the work up and
brings back posters, summaries and
episode titles. Modern agents draw on
Plex's online metadata; bundled
agents work locally.

**Analysis** — the second half of a
scan: the deep measuring of a file
(bitrates, loudness, thumbnails) that
follows the scanner's census. The
half that can need the network.

**Claimed** — bound to a Plex
account. An unclaimed server
(`claimed="0"` in its identity) runs
locally but owns none of the account
features.

**Client** — any app that browses and
plays from a server: the web app, the
television and phone apps, or another
program speaking the API.

**Client profile** — one XML file in
`Resources/Profiles/` describing what
a family of devices can play. The
transcoder matches a requesting
client against these before deciding.

**Codec (on-demand)** — a decoder or
encoder the server downloads from
Plex the first time it needs it, kept
under `Codecs/` in the support
folder. Verified by the publisher's
published hashes when fetched by hand.

**Decision** — the transcoder's
ruling before a stream: direct play,
direct stream, transcode, or refuse —
returned as codes with plain-language
text (1001 "Conversion OK" is this
guide's friend).

**Direct play** — the client can play
the file as it stands, so the server
sends the file itself, untouched.

**Direct stream** — the picture and
sound pass untouched but are
repackaged into a container the
client prefers. Cheap; no re-encoding.

**Library / section** — one promise:
a folder tree, of one media kind,
read by one scanner/agent pair. The
API calls it a section.

**Local item** — an item whose
identifier is a `local://` address:
known only by what its file and
filename said, matched to no online
record.

**Machine identifier** — the server's
own permanent ID, the thing an
account claims and clients remember.

**Managed user** — a viewer profile
under the server owner's account,
with its own PIN and restrictions.
For households, not guests.

**Part** — one physical file behind
an item, with its own address inside
the server (`/library/parts/…`). An
item can hold several parts.

**Plex Pass** — the paid tier:
hardware transcoding, app downloads,
DVR features, remote streaming rights
and refinements. The free server is
the same program with the fence
elsewhere.

**Plex Relay** — the fallback route
for remote viewing: when a client
cannot reach your server directly,
the stream can pass through Plex's
servers at reduced quality.

**Preferences** — the server's
settings, held as attributes in
`Preferences.xml` and reachable
through `/:/prefs`. The friendly
name lives there.

**Refresh** — a re-scan of one
library: new files in, changed files
re-probed, missing files out
(subject to the trash setting).

**Scanner** — the census taker: the
component that walks a library's
folders and parses filenames into
titles, years, seasons and episodes.

**Session** — one live stream's
working life: a transcoding session
has a folder, a playlist and segments,
and ends when the viewing does.

**Support folder** — the one
directory holding the server's
database, preferences, logs, metadata
and caches. The crown jewels live
here; back this up.

**Transcoding** — converting a stream
as it is served: smaller picture,
different codecs, to fit a client or
a connection. The server's heaviest
work, and chapter 8's subject.
