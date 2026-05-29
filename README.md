# Talks

Public presentations by Johan Wallquist. Partner Solution Architect, Microsoft.

Each talk has its own folder and runs as a live HTML deck on GitHub Pages.

**Landing page:** [jw-sthlm.github.io/talks](https://jw-sthlm.github.io/talks/)

## Talks

| Date | Title | Venue | Live |
|------|-------|-------|------|
| 2026-06-04 | Frontier Firms. Why your best customers are already different. | Microsoft Surface Launch, Tak Stockholm | [Open deck](https://jw-sthlm.github.io/talks/frontier-firms-2026/) |
| 2026-04 | Autonoma Agenter. Vad är det och vågar vi? | Internal Microsoft session | [Open deck](https://jw-sthlm.github.io/talks/agents-2026/) |

## How talks are published

Each talk lives in its own folder named `<topic>-<year>` (e.g. `frontier-firms-2026`). Inside the folder:

| File | Purpose | Linked publicly |
|------|---------|-----------------|
| `index.html` | The deck itself. Folder URL resolves to this. | Yes |
| `presenter.html` | Presenter view (speaker script + timer + thumbnails). | Direct URL only |
| `storyboard.html` | Full storyboard with script, risks, bridge notes. | Direct URL only |

The root [`index.html`](./index.html) is a card-based landing page that mirrors the table above.

When adding a new talk:

1. Build the deck locally under `C:\Users\jwallquist\projects\_speaking\<topic>\` (or wherever) with `deck.html`, `presenter.html`, `storyboard.html`.
2. Run `.\Publish-Talk.ps1 -Source <source-folder> -Slug <topic>-<year>`. The script renames `deck.html` to `index.html`, rewrites internal `src=`/`href=` path references, copies the other files, then commits and pushes.
3. Add the row to the talks table above.
4. Add a matching card to the root `index.html` landing page.
5. GitHub Pages picks it up within a minute.

For tweaks to an already-published talk, re-run the same `Publish-Talk.ps1` command. Use `-WhatIf` for a dry run, `-Message "..."` to override the commit subject, `-NoPush` to commit locally only.