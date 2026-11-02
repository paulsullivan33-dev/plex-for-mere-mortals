# Troubleshooting

**Outcome: the failure you are looking
at is one the lab has already met,
named, and either fixed or honestly
fenced.** Every entry here happened
in the transcripts; the order is the
order you will meet them.

## The new library is empty

**Symptom:** the section exists, the
scan finishes, nothing appears.
**Likely causes, in order:** the
folder path is wrong — remember the
server does not check it exists
(transcript `t09`), so a mistyped
path, an unmounted drive or a
capitalisation slip gives you a
perfectly healthy empty library; or
the files' names do not parse
(chapter 5), and the census left them
out rather than guess.
**Check:** read the library back with
`/library/sections/<id>/all` and walk
the path from the section's own
record — `/library/sections` prints
each section's locations exactly as
the server holds them.

## A refresh returns success, and nothing changes

**Symptom:** you added a file, called
refresh, got a 200 — and the film is
not there a minute later.
**Cause:** the scan's two halves
(chapter 6). The finding half was
queued behind an analysis pass that
was retrying something network-bound
— in the lab, a codec download that
could not arrive (transcript `t05`).
**Check:** `Logs/Plex Media Scanner.log`
shows which half is running and what
it is waiting on. Wait for the queue
to drain and refresh again; the lab's
second refresh added the film in a
second.

## No posters, no thumbnails

**Symptom:** items are present and
playable but bare; a film's advertised
`/thumb/` address answers 404.
**Cause:** posters from analysis are
frame grabs, and grabbing a frame
needs the video's decoder codec —
which is one of the on-demand
downloads (chapter 8). If that fetch
failed, analysis quietly skipped.
**Fix:** fetch the codec by hand
(recipe 4) and re-analyse the item:
`PUT /library/metadata/<id>/analyze`.
The lab's 404 became a real 640x360
poster the same minute (transcript
`t08`).

## A stream fails instead of converting

**Symptom:** a client that cannot
direct-play gets an error, not a
conversion; the session playlist
answers 500.
**Cause:** almost always a missing
on-demand codec, in the order the
transcript met them: the source's
decoder, then the encoders for the
target. The server log says the name
it is stuck on — search it for
`Failed to download XML for codec`.
**Fix:** recipe 4, once per name, then
retry the stream. If the log instead
says the *decision* failed with "not
enough bandwidth", your bitrate cap
is smaller than any playable version
of the file — raise it (chapter 8's
kbit/s trap).

## "Unable to find client profile"

**Symptom:** API-driven decision or
start requests return 400, and the
log complains it cannot find a client
profile for the device.
**Cause:** the transcoder matches the
client against `Resources/Profiles/`
by its declared headers; an anonymous
or novel client matches nothing.
**Fix:** identify the client the way
real clients do (product, platform,
platform version, device), as the
lab's Chrome declaration did
(transcript `t08`). Real apps never
see this; it bites scripts and
hand-rolled requests.

## The modern agent will not pair

**Symptom:** creating a library with
the current Plex Movie / Plex TV
Series agent returns "new scanner
needs to be paired with new agent".
**Cause:** on an unclaimed server the
modern agents' provider is inactive
(chapter 4); `GET /media/providers`
lists only the local library provider.
**Fix:** claim the server — the
wizard's order — or build the library
with a bundled agent, as the lab did
(transcript `t04`). The bundled
agents catalogue from filenames alone,
which is entirely serviceable for a
tidy library.

## A deleted file took its entry with it

**Symptom:** a file removed from disk
is gone from the library after the
next scan — history, collections and
all.
**Cause:** default behaviour:
"empty trash automatically after
every scan" (transcript `t09`).
**Fix:** none after the fact — the
metadata went with the item — but
turn the setting off in the library
settings if you want departures held
for your review, and remember
chapter 12's moral: the catalogue is
not the backup.

## The server is not answering at all

**Checks, in order:** the process
(`systemctl status plexmediaserver`
on an installed system); the port
(`ss -ltn | grep 32400`); and the tail
of `Logs/Plex Media Server.log` in
the support folder, which records
startup failures in plain language.
If the port is listening but the web
app misbehaves from one machine only,
suspect that machine's view — a stale
cached page — before the server's.
