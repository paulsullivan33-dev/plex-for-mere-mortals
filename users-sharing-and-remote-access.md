# Users, Sharing and Remote Access

**Outcome: you can name every feature
that lives on the account side of the
line from chapter 4, what each one
needs, and what it costs — with the
chapter's honesty label up front.**
This is the one chapter the lab could
not exercise: it had no Plex account,
and claiming is the key that turns
all of this. Everything here is
**documented-only**, written from
Plex's own documentation, and the
lab's contribution is the verified
view from the other side of the door
(chapter 4, transcript `t03`): what
the server reports about itself when
nobody has signed in.

## Users in your own house

On a claimed server, the account
holder is the administrator. Two
kinds of additional viewer exist:

- **Managed users** — profiles under
  your own account, the household
  pattern: a name, an optional PIN,
  and restrictions (which libraries,
  which age ratings). They exist for
  the people under your roof: a
  child's profile that sees the
  children's library and nothing else
  is the canonical example. Managed
  users are part of the free account
  holder's toolkit for home use.
- **Friends** — other Plex accounts
  you invite. A friend sees exactly
  the libraries you grant, streams
  from your server, and signs in as
  themselves on their own devices.
  Sharing is per library, can carry
  restrictions, and can be withdrawn.

Either way, the rule of the house is
worth stating as this guide's own
line: share your library the way you
would lend your shelves — with people
you know, of media you have the right
to share. The server's sharing
screens make the granting easy; the
judgement stays yours.

## Remote access: watching away

Claimed and signed in, the server
tries to make itself reachable from
the internet: it maps a port through
your router (automatically, via
UPnP, or by your manual forwarding to
32400), registers its address with
Plex, and clients away from home find
it through your account. When a
direct connection cannot be made,
**Plex Relay** can carry the stream
through Plex's servers instead, at
reduced quality — a fallback, not a
preference. The lab's server reported
the pre-account state of all this in
one attribute (`myPlexMappingState=
"unknown"`, transcript `t02`): no
mapping exists until an account asks
for one.

Two costs belong in this paragraph,
both current at the time of writing
and worth re-checking against Plex's
pages before you rely on them. Since
2025, streaming from your server
*while away from home* is a paid
feature: it needs **Plex Pass** on the
server owner's account, or a cheaper
**Remote Watch Pass** held by the
person watching. Streaming on the
home network remains free. And Plex
Pass itself is the tier chapter 12
prices: it also carries hardware
transcoding (chapter 8), downloads
into the apps for offline viewing,
the DVR features of the tuner
service, and a handful of smaller
comforts.

## What the server tells Plex

An account-bound server talks to
Plex's services — for the mapping
above, for metadata, for update and
codec fetches the lab *did* observe.
Plex's privacy settings let the owner
limit some diagnostics and telemetry,
and your library's contents are
catalogued on your server, not
published; but a claimed server is a
known device attached to an account,
and chapter 12 counts that honestly
among the trade's terms. The
unclaimed alternative is real but
narrower, and chapter 4 has already
paced out exactly where its fence
runs.

## The check

This chapter's check is the one the
lab ran, from the outside of the
door:

```bash
curl -s http://127.0.0.1:32400/myplex/account
```

Before claiming, expect the empty
answer of transcript `t03`. After you
claim through the web app, the same
address should name your account and
report the sign-in state as complete.
If it still says `signInState="none"`,
the claim did not take — and nothing
in this chapter will work until it
does.
