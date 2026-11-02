# Organising Your Files

**Outcome: your folders are shaped so
the scanner reads them the way you
mean them — because to Plex, the
filename is not a label on the media,
it is the message that describes it.**
Most misery attributed to Plex ("it
merged my films", "it thinks episode
nine is episode three") is a naming
story told to a literal-minded reader.
This chapter is that reader's grammar,
and every rule in its first half was
exercised on the lab's fixtures.

## Films: name, year, file

The shape the movie scanner reads
best, and the one every lab fixture
wears:

```text
movies/
  The Clockwork Garden (2021)/
    The Clockwork Garden (2021).mp4
  A Field Guide to Clouds (2018)/
    A Field Guide to Clouds (2018).mp4
  Harbour Lights (2024)/
    Harbour Lights (2024).mkv
```

One folder per film, the file inside
named exactly like the folder, and the
**year in brackets** doing quiet heavy
lifting: titles repeat (remakes,
coincidences), and the year is what
lets the agent pick the right work —
or, in the lab's case, confirms the
parse (`title` and `year` came back
exactly as written, transcript `t05`).
A folder per film also gives extras
and artwork somewhere to live that is
unambiguously *this film's*.

The container does not matter to the
grammar: the .mkv fixture was read
exactly like the .mp4s. What matters
is that the file is a video file, in
the library's tree, with the title
where the scanner looks for it.

## Programmes: show, season, s01e01

Television is a three-level sentence:

```text
tv/
  The Walnut Street Bakery/
    Season 01/
      The Walnut Street Bakery - s01e01.mp4
      The Walnut Street Bakery - s01e02.mp4
```

Show folder, `Season 01` folder, and
files carrying **`s01e01`** — season
and episode in the name. The lab's
scanner turned exactly this into a
show with one season and two episodes,
numbered correctly, without being
told anything else (transcript `t06`).
The episode *titles* came back as
"Episode 1" and "Episode 2": titles
live in the agent's online episode
lists, and an invented programme is in
nobody's list. For real programmes on
a claimed server, the agent fills
them in; the numbers never come from
the agent — they come from your
filenames, which is why getting them
right is the whole game.

Useful variations the scanner
understands (documented conventions,
stated here so your real library can
use them): a second numbering style,
`1x01`, is also read; a file holding
several episodes names them
`s01e01-e02`; specials belong in a
`Season 00` folder; and a show's year
can sit in its folder name —
`Show Name (2019)` — when two shows
share a title.

## The useful extras

Documented conventions again, each
sitting beside the file it describes:

- **Subtitles** as sidecar files with
  the same name plus a language code:
  `The Clockwork Garden (2021).en.srt`
  is offered to viewers as English.
- **Editions** in braces in the file
  name — `{edition-Director's Cut}` —
  keep two cuts of one film apart
  instead of merged.
- **Trailers and extras** in named
  subfolders (`Trailers/`, `Extras/`)
  or with suffixes (`-trailer`) in a
  film's folder.
- **Music** follows the same instinct
  one level down: `Artist/Album/01 -
  Track Name.flac`, read from folder
  shape and embedded tags together.

## What the scanner ignores, and what trips it

Files it cannot place it leaves out
rather than guessing: the census is
conservative, which is why chapter 6
can promise that a refresh never
invents items. The classic trips are
all shape errors: episodes loose in
the show folder with no season;
several films sharing one folder with
years missing, inviting a merge; a
film's name carrying a sequel number
the agent reads as a *part* (files
named `... pt1`/`... pt2` are treated
as one work in pieces, by design);
and downloads still wearing release
-group names, where the "title" the
scanner extracts is whatever survived
the noise. The fix is never in Plex's
settings. It is a rename, and then a
refresh.

## The check

After any tidy-up, ask the library
what it thinks it holds:

```bash
curl -s "http://127.0.0.1:32400/library/sections/2/all"
```

Read the titles and years that come
back against the folders you meant.
Where they differ, believe the
listing: it is showing you your
filenames as the scanner read them.
