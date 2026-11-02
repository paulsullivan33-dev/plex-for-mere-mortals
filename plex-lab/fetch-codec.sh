#!/bin/sh
# fetch-codec.sh - fetch one of Plex Media Server's on-demand codecs
# by hand, verify it against Plex's own published SHA-1, and place it
# where the server looks for it.
#
# Why: the server downloads some codecs from servers.plex.tv the
# first time it needs them. On a network where that fetch is refused
# (this lab's sandbox was one), analysis, posters and transcoding
# quietly fail. Doing the fetch with curl and checking the hash is
# the manual equivalent - the server picks the file up with no
# restart. See transcript t08 for the four codecs the lab needed.
#
# Usage: ./fetch-codec.sh <codec-name> <support-dir>
#   e.g. ./fetch-codec.sh h264_decoder "$HOME/.local/share/plexmediaserver"
# The codec name is the one in the server log line
# "CodecManager: obtaining decoder/encoder '<name>'" - note the log
# says 'libx264' while the download is named 'libx264_encoder'.
set -eu

CODEC="${1:?usage: fetch-codec.sh <codec-name> <support-dir>}"
SUPPORT="${2:?usage: fetch-codec.sh <codec-name> <support-dir>}"
API="https://servers.plex.tv/api/codecs/${CODEC}?build=linux-x86_64-standard"

XML="$(curl -fsSL "$API")"
URL="$(printf '%s' "$XML" | grep -o 'url="[^"]*"' | head -1 | sed 's/url="//; s/"$//')"
SHA="$(printf '%s' "$XML" | grep -o 'fileSha="[^"]*"' | head -1 | sed 's/fileSha="//; s/"$//')"
VER="$(printf '%s' "$XML" | sed -n '2p' | grep -o 'version="[^"]*"' | sed 's/version="//; s/"$//')"
FILE="$(basename "$URL")"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fsSL -o "$TMP/$FILE" "$URL"
GOT="$(sha1sum "$TMP/$FILE" | cut -d' ' -f1)"
if [ "$GOT" != "$SHA" ]; then
  echo "hash mismatch for $FILE: got $GOT, Plex published $SHA" >&2
  exit 1
fi

DEST="$SUPPORT/Plex Media Server/Codecs/$VER-linux-x86_64"
mkdir -p "$DEST"
cp "$TMP/$FILE" "$DEST/$FILE"
echo "installed $FILE (sha1 verified) into $DEST"
