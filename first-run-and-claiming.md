# First Run and Claiming Your Server

**Outcome: you know exactly what state
a brand-new server is in, what the
setup flow asks of you, and what the
word *claimed* buys — including what
it doesn't.** Of all the chapters, this
is the one where the lab's headless
view is most instructive, because the
lab could see the whole shoreline of
setup and honestly report where the
water starts.

## What a first run looks like

A new server boots, builds its
database from the template in the
package, and starts listening — all
before it knows anything about you.
The lab watched it happen
(transcript `t02`): the support folder
fills with `Preferences.xml`, a `Logs`
folder, empty `Metadata` and `Cache`
trees, and a small `Setup Plex.html`
help page. The server names itself
after the machine it runs on until you
tell it otherwise (the lab's called
itself `htch-runtime`, after its
hostname; the root document's
`friendlyName` is where it says so).

Open the web app from a machine on
the same network:

```text
http://<server-address>:32400/web/
```

On the lab server that address answers
with a redirect whose tail is the
whole story:

```text
Location: http://127.0.0.1:32400/web/index.html#!/setup/6b347c5e…
```

The web app is served by the server
itself — the page the lab fetched is
30 KB of shell that then talks to the
API — and on an unclaimed server it
opens at `#!/setup/`: the setup flow.
That flow, in a browser, walks through
naming the server, signing in to a
Plex account to claim it, and offering
to build your first libraries.

## Claiming, precisely

To **claim** a server is to bind its
machine identifier to a Plex account.
Afterwards the account *owns* the
server: it appears in your account's
list of devices, only your account
administers it, and the account-bound
features of chapter 9 — remote access,
sharing, managed users — have an owner
to attach to. The state is visible
from both sides. Before claiming, the
lab's account endpoint answered:

```bash
curl -s http://127.0.0.1:32400/myplex/account
```

```xml
<MyPlex username="" mappingState="unknown" signInState="none"
  subscriptionActive="0">
</MyPlex>
```

`username=""`, `signInState="none"`:
nobody home. Claiming requires signing
in through the web app (or presenting
a claim token from plex.tv/claim, the
route headless installers use). Both
routes need a real account and an
interactive step, so the lab did
neither, and everything past this line
in the chapter is documented-only,
taught from Plex's own material: the
claim itself, the wizard's library
step on a claimed server, and what
changes in the menus afterwards.

## What unclaimed still does

The useful surprise, proven piece by
piece in the transcripts, is how much
of Plex is *not* behind that line.
While unclaimed, from the local
network, the lab's server:

- answered its identity and root
  documents with no token at all —
  loopback and local requests are
  trusted until an owner exists;
- created, scanned and refreshed real
  libraries (chapters 6, transcripts
  `t04`–`t06`);
- served a media file back through its
  own API, byte for byte (`t07`);
- renamed itself through settings,
  persisting to `Preferences.xml`
  (`t07`);
- made transcoding decisions and
  converted a clip on request (`t08`).

Two things it would not do are just
as instructive. The modern metadata
agents would not pair with a library:
their provider activates with the
claim, so the lab's libraries were
built with the bundled agents instead
(`t04`). And the account features —
remote access mapping, sharing,
sign-in — reported themselves plainly
absent (`mappingState="unknown"`,
`t03`) rather than pretending.

## The decision, framed

Claim your server if it is *your*
server on *your* network and you want
any of: watching away from home,
sharing with family accounts, the
modern metadata agents, or Plex Pass.
Run unclaimed — quite legitimately —
if the server never leaves the home
network and the bundled agents' local
cataloguing is enough, accepting that
Plex will keep offering the sign-in
and that some corners stay dark. What
this guide will not do is treat the
account as either a trap or a
formality: it is a trade, priced in
chapter 12, and the transcripts exist
so you can see exactly which side of
the line each feature lives on.
