# What Plex Is

**Outcome: you can say what Plex is in
one breath — a server that organises the
media you already own into a library,
and serves that library to apps on your
screens.** Everything else in this guide
is detail hanging off that sentence.

The shape of the problem is familiar.
Your films are on one drive, your
programmes on another, your music
somewhere else again. The television
cannot see any of them. The tablet can
see one folder if you share it, but
shows raw filenames and forgets where
you stopped watching. Plex answers by
putting one program in the middle:
**Plex Media Server**. You install it
on the machine that holds the files —
a desktop, a spare PC, a NAS box. You
tell it which folders are films, which
are programmes. It reads the names,
builds a **library** — titles, years,
seasons, posters, summaries — and from
then on the files have a front door.

That front door is any **client**: the
Plex app on a smart TV, phone, tablet,
streaming stick or games console, or
the **web app** the server itself
serves to a browser. The client shows
the library, not the folders. When you
press play, one of two things happens.
If the client can play the file exactly
as it stands, the server sends the file
— **direct play**. If it cannot (the
format is foreign, or the connection
is too slow for the file's size), the
server converts the stream as it goes —
**transcoding**, chapter 8's subject.
Either way, the file never had to move
house, and your place in the programme
is remembered across devices.

## The account layer, sized honestly

Plex-the-company offers accounts, and
its materials gently assume you will
sign in. An account **claims** your
server — binds it to you — and unlocks
the parts of Plex that live beyond
your own network: watching away from
home, sharing your library with other
accounts, managed users for the
household, and the paid **Plex Pass**
tier (chapter 9). What surprises people
is how much sits *below* that layer.
The lab that wrote this guide never
signed in. Its server was never
claimed, and it still scanned two
libraries, organised six fixture files
correctly, served a file back byte for
byte and transcoded a clip on request
(transcripts `t02`–`t08`). On your own
network, an unclaimed server is a
working server. Claiming adds the
account's reach; it is not what makes
the machine run.

There is a second distinction worth
making on day one. Plex also runs a
streaming service — free films, live
channels, a rental shelf — under the
same name and inside the same apps.
That is Plex-the-company's library,
not yours. This guide is about your
server and your files; where the
service appears in the apps, you can
hide its rows and carry on.

## A first taste

Once the server is installed (chapter
3) and running, it introduces itself to
any program that asks, no account
needed. This is the lab server's
answer, trimmed:

```bash
curl http://127.0.0.1:32400/identity
```

```xml
<MediaContainer claimed="0"
  machineIdentifier="6b347c5e…"
  version="1.43.5.11079-b3b13e506">
</MediaContainer>
```

Three facts in one glance: which
server this is (its **machine
identifier**), what version it runs,
and `claimed="0"` — nobody owns it yet.
Chapter 4 is about what changing that
zero involves, and what it buys.

## What it is not

Plex is not a downloader: it organises
and plays media you already have, and
getting media is neither its job nor
this guide's. It is not open source —
the server is a free-of-charge but
closed program, which chapter 12
weighs honestly. It is not a backup:
the library is a catalogue and a
streaming service for your files, and
deleting a file deletes the thing
itself, as chapter 6 demonstrates. And
it is not the only shape of answer —
chapter 11 covers Jellyfin, which does
the same job with no account layer at
all, and Kodi, which skips the server
entirely.

## Who it is for

The household with media scattered
across drives and one television that
should just play it. The collector
whose folders have outgrown filenames
as a finding system. The person who
wants their own recordings and rips
treated with the polish the streaming
services give theirs. The common
thread is one server, one library,
and screens that should all see the
same thing.
