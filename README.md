# Talks

Public presentations by Johan Wallquist. Partner Solution Architect, Microsoft.

Each talk has its own folder and runs as a live HTML deck on GitHub Pages.

**Landing page:** [jw-sthlm.github.io/talks](https://jw-sthlm.github.io/talks/)

## Talks

| Date | Title | Venue | Live |
|------|-------|-------|------|
| 2026-06-04 | Frontier Firms. Why your best customers are already different. | Microsoft Surface Launch, IMA TAK Stockholm | [Open deck](https://jw-sthlm.github.io/talks/frontier-firms-2026/) |
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

1. Create `talks/<topic>-<year>/` and drop `index.html` in it (rename `deck.html` if needed).
2. Add the row to the table above.
3. Add a matching card to the root `index.html` landing page.
4. Commit and push. GitHub Pages picks it up within a minute.