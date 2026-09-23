# Tutorial: how to extend this site

This file is **not part of the built site.** MkDocs only builds files inside
`docs/` — this lives at the repo root, same as `README.md`, so it has zero
effect on the live page. It's just a reference for future-you.

## The map

| Path | What it controls |
|---|---|
| `docs/*.md` | The actual page content (Home, Experience, Publications, Skills, CV, Contact) |
| `docs/stylesheets/extra.css` | Every color, the frosted-glass nav, card/tag/timeline styling, the molecule watermark |
| `docs/assets/img/` | Photos and the background SVG |
| `docs/assets/cv/` | The CV PDF |
| `mkdocs.yml` | Site title, **the nav bar** (`nav:`), color scheme wiring, enabled features |
| `Makefile` | `make serve` / `make build` shortcuts |
| `.github/workflows/deploy.yml` | Auto-builds + deploys to Pages on every push to `main` |

## Editing an existing page

Just open the `.md` file and edit the text — it's regular Markdown. The only
non-standard bits are a handful of reusable `<div class="...">` wrappers
already used throughout:

- `.card-grid` / `.card` — the boxes on Home ("Education", "Current Research"…) and Skills
- `.timeline` / `.timeline-item` — the dotted line on Experience
- `.pub-list` / `.pub-item` — the left-bordered boxes on Publications
- `.tag-list` — the pill-shaped skill badges (wrap inline code like `` `Python` `` inside it)
- `.hero` / `.hero-copy` / `.hero-photo` — the two-column intro block on Home

Copy an existing block of one of these when you want another instance (e.g.,
a 4th card, a 6th timeline entry) — no CSS work needed, it's already styled.

## Adding a brand-new page

Say you want a "Projects" tab:

1. Create `docs/projects.md` with a `# Projects` heading and content.
2. In `mkdocs.yml`, add it to the `nav:` list:
   ```yaml
   nav:
     - Home: index.md
     - Experience: experience.md
     - Projects: projects.md   # <- new
     - Publications: publications.md
     ...
   ```
3. `make serve` to check it, then commit + push.

That's it — it appears as a new tab in the frosted nav bar automatically,
using the same theme.

## Local preview loop

```bash
make serve      # http://127.0.0.1:8000, live-reloads as you edit
```

Check it looks right, then:

```bash
git add -A
git commit -m "..."
git push
```

GitHub Actions takes it from there.

## Colors / design system

All colors live once, at the top of `docs/stylesheets/extra.css`, split into
a light-scheme block (`[data-md-color-scheme="default"]`) and a dark-scheme
block (`[data-md-color-scheme="slate"]`). Each block defines the same set of
custom properties:

- `--ink` — main text color
- `--paper` — the page's conceptual background tone (used for text drawn on
  top of solid accent-colored surfaces, like button labels)
- `--muted` — secondary/dimmer text (taglines, dates)
- `--warm` — the decorative pop color (timeline dots, publication borders)
- `--glass-header-bg` / `--glass-tabs-bg` — the frosted-glass tint
- `--card-bg` / `--card-border`, `--tag-bg` / `--tag-border`, `--pub-bg` —
  component-specific tints

To re-theme the whole site, change the five palette hex values at the very
top of the file (`:root { --teal: ...; }`) and the two scheme blocks that
reference them. Everything else (buttons, cards, tags, the logo pill) pulls
from these variables, so it stays consistent automatically.

**Watch out for contrast bugs** (this bit me twice while building this
site): anywhere a color is used as *both* a background and the text/icon
color drawn on top of it, double check they're not accidentally the same
value. This specifically applies to `--md-button--primary` (bg vs. text)
and `--md-primary-bg-color` (the color of the header's dark-mode toggle and
GitHub star/fork icons, drawn on top of the header's background).

## For later: a blog

Two ways to do this, in increasing order of effort:

**Simple (no plugin):** a `docs/blog/` folder with one `.md` file per post
plus a hand-written `docs/blog/index.md` that links to each one, added as a
nav entry. Full control, but you maintain the "latest posts" list by hand.

**Proper blog (recommended):** Material for MkDocs ships an actual `blog`
plugin (bundled since v9.5, which is what this site already pins in
`pyproject.toml`) that gives you automatic date-sorted listing, tags, an
archive, and even RSS — for free. Rough shape:

```yaml
# mkdocs.yml
plugins:
  - blog

nav:
  - Home: index.md
  - Blog: blog/index.md
  ...
```

Then posts live in `docs/blog/posts/*.md` with a small front-matter block
(`date:`, `categories:`), and the plugin builds the listing/archive pages
for you.

## For later: "Travel Diaries"

Same mechanism as the blog — and actually, the **blog plugin supports more
than one independent blog instance** on the same site, each with its own
folder, its own archive, and its own nav entry. So "Travel Diaries" could
literally be a second blog:

```yaml
plugins:
  - blog:
      blog_dir: blog
  - blog:
      blog_dir: travel
      blog_toc: true

nav:
  - Home: index.md
  - Blog: blog/index.md
  - Travel Diaries: travel/index.md
  ...
```

Each entry (`docs/travel/posts/japan-2027.md`, etc.) shows up automatically
in its own dated, tagged listing — a proper travel notebook, separate from
the blog, both linked from the top menu, no extra CSS needed since it
inherits the whole existing theme (frosted glass, palette, dark mode).
