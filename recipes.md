# Recipes

**Outcome: five jobs from this guide's
chapters, done end to end.** Each
recipe names its transcript; the API
versions are what the lab ran against
its unclaimed server, and the same
jobs in the web app follow the same
shapes.

## 1. A first library from one folder

You have a folder of films with
reasonable names. Make it a library
and read it back:

```bash
curl -X POST "http://127.0.0.1:32400/library/sections\
?name=Movies&type=movie\
&agent=com.plexapp.agents.imdb\
&scanner=Plex%20Movie%20Scanner\
&language=en&location=/path/to/movies"
curl -s "http://127.0.0.1:32400/library/sections/2/all"
```

On a claimed server, choose the
modern Plex Movie agent instead — the
wizard does. Verify by titles, not by
hope (chapters 5–6, transcript `t04`).

## 2. Add a film the tidy way

Name it before you file it:
`Film Title (Year)/Film Title (Year).mkv`
inside the library's tree. Then one
refresh, then read the library back:

```bash
curl -s "http://127.0.0.1:32400/library/sections/2/refresh"
sleep 5
curl -s "http://127.0.0.1:32400/library/sections/2/all" \
  | grep -o 'title="[^"]*"'
```

The lab's Paper Boats landed in about
a second once the analysis queue was
clear (transcript `t05`). If yours
does not land, the name is the first
suspect — chapter 13 walks the list.

## 3. Rename the server

Settings are preferences; the friendly
name is one:

```bash
curl -X PUT "http://127.0.0.1:32400/:/prefs\
?FriendlyName=Plex%20Lab"
curl -s http://127.0.0.1:32400/ | grep -o 'friendlyName="[^"]*"'
# friendlyName="Plex Lab"
```

The change persists into
`Preferences.xml` immediately
(transcript `t07`) — clients may keep
showing the old name until they
refresh their view.

## 4. Fetch a codec by hand

A conversion or analysis fails and
the server log says a codec could not
be downloaded (chapter 8). Fetch the
named codec with its publisher's hash
as the receipt, using the lab's
script:

```bash
plex-lab/fetch-codec.sh h264_decoder /var/lib/plexmediaserver
# installed libh264_decoder.so (sha1 verified) into
# …/Plex Media Server/Codecs/a336ba9-…-linux-x86_64
```

Repeat for each name the log asks
for — the lab needed four. No restart
is required; the next attempt picks
the files up (transcript `t08`).

## 5. Prove the server serves

Settle any "is it really working?"
argument with bytes, not impressions.
Take an item's part key (chapter 7)
and fetch its first kilobyte:

```bash
curl -s -r 0-1023 \
  "http://127.0.0.1:32400/library/parts/6/…/file.mp4" \
  -o slice.bin -w "%{http_code} %{size_download}\n"
# 206 1024
```

206 is a partial serving — a player
asking for exactly what it needs —
and the kilobyte will hash-match the
first kilobyte of the file on disk
(transcript `t07` addendum). The same
shape works from any machine allowed
to reach the server.
