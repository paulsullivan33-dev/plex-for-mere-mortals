# The Neighbours

**Outcome: you can place Plex among
its alternatives without caricature —
what each neighbour does better, what
it gives up, and when the honest
answer is to switch.** The lab ran
Plex only; the neighbours are
characterised from their own
documentation, and the Jellyfin and
Kodi guides in this series ran their
subjects in their own labs if you
want their transcripts.

## Jellyfin — the open-source twin

Jellyfin does the same job in the
same shape: a server, libraries built
from the same naming grammar, clients
on everything, transcoding when a
client needs it. The differences are
the ones this guide has been pacing
around. Jellyfin is free and open
source, with **no account layer at
all** — its users are accounts *on
your server*, its metadata comes from
open sources, and nothing in it asks
to phone home. What you give up for
that purity: the clients are a little
less polished on some platforms, the
metadata matching a little less
smoothing-over of messy filenames,
and the account-side comforts of
chapter 9 (a company-run rendezvous
for remote access, a relay when it
fails) simply do not exist — remote
access is your own networking to
arrange, which this series' Tailscale
guide makes genuinely pleasant. If
chapter 12's limits are the ones that
bite you, Jellyfin is not a compromise;
it is the same house with the
landlord removed.

## Kodi — the library that is the player

Kodi skips the server entirely: it is
a player that builds its library on
the machine attached to the
television, reading the same folders
(its naming grammar is a close cousin
of chapter 5's). For one screen and
one room it is simpler than anything
in this guide, and its local playback
is superb. What it does not do is
*serve*: a second screen means a
second library (or shared-database
plumbing), there is no transcoding
for a phone on a train, and your
place in a programme lives on the one
machine. Households grow into Plex's
shape; single rooms may never need it.

## Emby — the middle sibling

Emby began as kin to Jellyfin (the
projects share ancestry) and keeps
the same architecture with a
commercial polish layer: its server
is free to run, with a paid Premiere
tier carrying its extras — a position
very like Plex's own. Choose it by
the same tests you would apply here:
run the free tier against your files
and see whether its clients and
matching suit your household better.

## The specialists, and the plain share

For music alone, dedicated servers
(this series covers Navidrome and
Audiobookshelf) give a music library
more care than any generalist. For
audiobooks and podcasts especially,
remembered position across devices is
the whole game and the specialist
plays it best. And the floor under
everything: a plain network share
(Samba or NFS, same series again)
plus a competent player app is a
media system — no catalogue, no
posters, no transcoding, but also
nothing to claim, update or feed.
Plex earns its place when the
catalogue and the serving are worth
a program's keep; the day they are
not, the share is still there.

## Choosing, in one paragraph

One room, one screen: Kodi. Many
screens, your own network, no
accounts anywhere: Jellyfin. Many
screens, visitors with their own
accounts, remote watching arranged
for you, and a bill you accept for
it: Plex — the subject of this guide,
with its price tag stated in the next
chapter rather than discovered in
the settings.
