# Talks

Public presentations by Johan Wallquist.

Each talk has its own folder and runs as a live HTML deck on GitHub Pages.

**Landing page:** [jw-sthlm.github.io/talks](https://jw-sthlm.github.io/talks/)

## Talks

| Date | Title | Venue | Live |
|------|-------|-------|------|
| 2026 | När AI börjar göra jobbet | Nexer kundevent (Swedish, with Sara Kiraly) | [Open talk](https://jw-sthlm.github.io/talks/nexer-frontier-event-2026/) |
| 2026 | What happens when AI joins your project team? | Capgemini / Graduate consulting | [Open talk](https://jw-sthlm.github.io/talks/capgemini-graduate-consulting-2026/) |
| 2026 | When Projects Move Faster, Who Captures the Upside? | Partner Day / Frontier Consultancy | [Open talk](https://jw-sthlm.github.io/talks/frontier-partner-day-2026/) |
| 2026-08 | What happens when AI joins the project team? | KPMG Learning Days | [Open deck](https://jw-sthlm.github.io/talks/agentic-future-2026/) |
| 2026-06-04 | Frontier Firms. Why your best customers are already different. | Microsoft Surface Launch, Tak Stockholm | [Open deck](https://jw-sthlm.github.io/talks/frontier-firms-2026/) |
| 2026-04 | Autonoma Agenter. Vad är det och vågar vi? | Internal Microsoft session | [Open deck](https://jw-sthlm.github.io/talks/agents-2026/) |

## How talks are published

### Partner Day audience release

The Partner Day folder contains a landing page, the interactive `deck.html`,
an audience-only `audience.pdf`, and a title-slide thumbnail. Speaker notes and
rehearsal files are excluded. The approved files are also preserved under
`releases/v0.11-20260922/`; an existing release must not be overwritten.

The mobile update is archived under `releases/v0.11-mobile-20260922/`.
It keeps the full slide visible on small screens and adds touch navigation.
The original release remains unchanged.

Copy only these reviewed public files when updating this talk. Do not use the
legacy publisher below for an audience-only release: it also copies presenter
and storyboard files. Files remain public even when the library does not link
to them.

### Earlier decks

Capgemini uses the same audience-only package, with its approved v4 files
preserved under `capgemini-graduate-consulting-2026/releases/v4-20260922/`.
Its 14-page audience PDF is separate from the interactive presentation.
Johan's visible speaker contact remains on the closing slide.

Each talk lives in its own folder named `<topic>-<year>` (e.g. `frontier-firms-2026`). Inside the folder:

| File | Purpose | Linked publicly |
|------|---------|-----------------|
| `index.html` | The deck itself. Folder URL resolves to this. | Yes |
| `presenter.html` | Presenter view (speaker script + timer + thumbnails). | Direct URL only |
| `storyboard.html` | Full storyboard with script, risks, bridge notes. | Direct URL only |

The root [`index.html`](./index.html) is a card-based landing page that mirrors the table above.

When adding a new talk:

1. Build the deck in any local source folder with `deck.html`, `presenter.html`, and `storyboard.html`.
2. Run `.\Publish-Talk.ps1 -Source <source-folder> -Slug <topic>-<year>`. The script renames `deck.html` to `index.html`, rewrites internal `src=`/`href=` path references, copies the other files, then commits and pushes.
3. Add the row to the talks table above.
4. Add a matching card to the root `index.html` landing page.
5. GitHub Pages picks it up within a minute.

For tweaks to an already-published talk, re-run the same `Publish-Talk.ps1` command. Use `-WhatIf` for a dry run, `-Message "..."` to override the commit subject, `-NoPush` to commit locally only.

## License

Original scripts and site code are MIT licensed. Original presentation text and diagrams are available under CC BY 4.0. Microsoft and third-party trademarks, screenshots, logos, and externally owned material are excluded. See [LICENSE.md](LICENSE.md).