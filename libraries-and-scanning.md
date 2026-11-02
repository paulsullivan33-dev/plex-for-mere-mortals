# Libraries and Scanning

**Outcome: you can create a library,
understand what a scan actually does
in its two halves, add media so it
lands first time, and predict what a
refresh does when a file has gone.**
On a claimed server you will do this
in the web app's friendly screens; the
lab did it through the API, which has
the advantage of showing its working —
every step below names its transcript.

## Creating a library

A library is created with a name, a
type, an agent/scanner pair, a
language, and at least one folder
(chapter 2). The lab's film library,
in one request (transcript `t04`):

```bash
curl -X POST "http://127.0.0.1:32400/library/sections\
?name=Movies&type=movie\
&agent=com.plexapp.agents.imdb\
&scanner=Plex%20Movie%20Scanner\
&language=en&location=/path/to/movies"
# 201 Created
```

Three lessons ride along. The
parameters travel in the address, not
the body — the form-encoded version
was refused. The language the modern
agent wants is `en-US`, the bundled
agents take `en`. And the pairing
rule from chapter 4: pre-claim, the
modern agent cannot be paired and the
server says so in plain text
("new scanner needs to be paired with
new agent"); the bundled agent pairs
at once. A television library is the
same request with `type=show`, the
series scanner and the TVDB agent
(transcript `t06`).

One liberty in that request deserves
a warning label. Point the location
at a folder that does not exist and
the server still creates the library
(transcript `t09`): Plex trusts the
path you give it. The section simply
sits empty. If a new library shows
nothing, the folder path — spelling,
capitalisation, whether the drive is
even mounted — is the first suspect,
before any thought of agents.

## The two halves of a scan

Creating the library starts its first
scan, and a scan is two different
jobs wearing one name:

1. **Finding.** The scanner walks the
   tree, parses names (chapter 5),
   probes each file's container and
   streams, and writes the item into
   the database. This half is local
   and quick: the lab's four-film
   refresh added its new film about a
   second after the walk reached it
   (transcript `t05`).
2. **Analysing.** For each item, the
   server measures deeper — bitrates
   over time, loudness, thumbnails and
   preview frames, subtitle and stream
   details. This half can reach the
   network: it is where the on-demand
   codecs of chapter 2 are fetched,
   and where the lab's sandbox slowed
   everything down. The first refresh
   in transcript `t05` returned success
   and *then* seemed to do nothing for
   three minutes, because the finding
   half was queued behind an analysis
   pass retrying a codec download that
   could not arrive. The items were
   never lost; they were waiting their
   turn behind a different job.

Hold those halves apart and most scan
mysteries dissolve. A film that is
*missing* is a finding problem
(naming, folder, path). A film that
is present but bare — no poster, no
thumbnails — is an analysis problem,
and chapter 13 has its address.

## Refreshing: adding and removing

The rhythm for new media is: put the
file in place, named as chapter 5
says, then refresh the section:

```bash
curl "http://127.0.0.1:32400/library/sections/2/refresh"
```

Plex also re-scans on its own
schedule and can be set to notice
folder changes automatically; the
manual refresh is the one you can
watch in `/activities` and in the
scanner's log. A refresh is a census,
not a merge: new files arrive as new
items, changed files are re-probed,
and files that have *gone* are
removed. That last behaviour the lab
proved by deleting a fixture and
refreshing (transcript `t09`): with
"empty trash automatically after
every scan" at its default, the item
left the library entirely — metadata
and all — rather than lingering as a
greyed-out ghost. Turn that setting
off if you would rather review
departures yourself; know that the
default is a tidy desk, not an
archive.

## The check

```bash
curl -s "http://127.0.0.1:32400/library/sections/2/all" \
  | grep -o 'title="[^"]*"'
```

Run it after every scan you care
about and read your library back to
yourself. Four titles went in as
fixtures; four titles (then three,
after the deletion) came back. The
library is what this listing says it
is — everything else is intention.
