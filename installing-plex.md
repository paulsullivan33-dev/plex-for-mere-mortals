# Installing Plex Media Server

**Outcome: a Plex Media Server of a
known version, from Plex's own site,
running on your machine and answering
on port 32400.** This guide's lab
installed version **1.43.5.11079**;
yours will be newer, and nothing here
depends on the exact digits.

## Getting the genuine package

Plex publishes its own downloads and
its own index of them. The lab asked
the index first:

```bash
curl -s https://plex.tv/api/downloads/5.json
```

That document lists, per platform, the
current version, the package address
and a **checksum**. For 64-bit Ubuntu
or Debian the entry the lab used was:

```text
label:    Ubuntu (16.04+) / Debian (8+) - Intel/AMD 64-bit
file:     plexmediaserver_1.43.5.11079-b3b13e506_amd64.deb
sha1:     a0a0b8fa92aeea65128af07b7c6cffc994ab8795
```

```bash
sha1sum plexmediaserver_1.43.5.11079-b3b13e506_amd64.deb
# a0a0b8fa92aeea65128af07b7c6cffc994ab8795 — matches
```

The check matters more than the
ceremony around it: a media server
will be trusted with your whole
collection and a port on your network,
so "downloaded from somewhere" is not
good enough when the publisher hands
you the fingerprint. Transcript `t00`
keeps the whole exchange.

The same page offers the other shapes
of install: packages for Red Hat
family systems and ARM boards (a
Raspberry Pi build included), disk
images for the major NAS brands, and
installers for Windows and macOS,
where the server runs as an ordinary
application in the tray or menu bar.
The ideas in this guide are the same
on all of them; the commands are the
Linux ones.

## Installing on Ubuntu or Debian

On a real machine the package installs
the ordinary way:

```bash
sudo apt install ./plexmediaserver_1.43.5.11079-b3b13e506_amd64.deb
```

That lays the cast of chapter 2 into
`/usr/lib/plexmediaserver`, creates a
`plex` user to run as, puts the
support folder at `/var/lib/plexmediaserver`,
and registers a service so the server
starts at boot and can be managed with
the usual tools:

```bash
sudo systemctl status plexmediaserver
sudo systemctl restart plexmediaserver
```

Full disclosure about the lab: its
sandbox has no service manager and its
rules keep every write inside the lab
folder, so instead of installing, the
lab unpacked the very same package
(`dpkg-deb -x`) and ran the unmodified
server program from the unpacked tree,
with its support folder pointed at a
lab directory (transcripts `t00`,
`t02`). Same binaries, same version,
same behaviour — all differences are
in who starts it and where its files
live, and the guide says so wherever
that could matter.

## The check

About twenty seconds after first
start, the server answers for itself:

```bash
curl -s http://127.0.0.1:32400/identity
```

```xml
<MediaContainer size="0" apiVersion="1.2.3" claimed="0"
  machineIdentifier="6b347c5ef9d44a72830310b64fdba029201bd2d3"
  version="1.43.5.11079-b3b13e506">
</MediaContainer>
```

`version` is the package's own version
string; `claimed="0"` is the honest
state of a server nobody has signed
in to yet — chapter 4's subject. If
the command is refused instead, the
server is not running: on an installed
system, the service status above and
the tail of `Logs/Plex Media Server.log`
in the support folder are the two
places that will say why.

## Keeping it current

The package you installed does not
update itself through your system's
package manager unless you add Plex's
repository — the installer mentions
this, and the server's own settings
can check for and (on some platforms)
apply updates. The habit this guide
recommends is the dull one: when the
server banner says an update exists,
fetch the new package from the same
downloads page, verify it the same
way, install it over the old. Your
support folder — library, preferences
and all — is untouched by the swap.
