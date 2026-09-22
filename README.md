# github-portfolio

Personal portfolio site for Adithya Maurya K R, published with [GitHub Pages](https://pages.github.com/).

Live at: **https://adithyamauryakr.github.io/github-portfolio/** (once Pages is enabled, see below).

## How this is built

No TypeScript, no Node.js, no JavaScript build step. The site is plain Python:

- **[MkDocs](https://www.mkdocs.org/)** turns the Markdown pages in [docs/](docs/) into a static
  HTML site.
- **[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)** is the theme, customized
  in [docs/stylesheets/extra.css](docs/stylesheets/extra.css) with the site's color palette and a
  frosted-glass top navigation bar.
- **[uv](https://docs.astral.sh/uv/)** manages the Python environment and dependencies, the same
  tool used by [jlevy/simple-modern-uv](https://github.com/jlevy/simple-modern-uv) — a lightweight
  Python project setup, no TypeScript involved.

Content lives in [docs/*.md](docs/) as plain Markdown, so updating text (experience, publications,
skills, contact info) never requires touching CSS or config.

## Local preview

Requires [uv](https://docs.astral.sh/uv/getting-started/installation/) installed. Then, from the
repo root:

```bash
make serve
```

This installs dependencies into a local `.venv` and starts a dev server at
`http://127.0.0.1:8000` that live-reloads as you edit files in `docs/`.

Other commands (see [Makefile](Makefile)):

```bash
make install   # create/update the .venv
make build     # build the static site into site/
make clean     # remove the built site/
```

## Deployment

[.github/workflows/deploy.yml](.github/workflows/deploy.yml) builds the site with `uv` + `mkdocs`
and deploys it to GitHub Pages automatically on every push to `main`.

One-time setup (only needed once, in the GitHub repo, not locally):

1. Go to **Settings → Pages** in this repository.
2. Under **Build and deployment → Source**, choose **GitHub Actions**.
3. Push to `main` (or re-run the "Deploy portfolio to GitHub Pages" workflow from the
   **Actions** tab) — the site will publish to `https://adithyamauryakr.github.io/github-portfolio/`.

## Updating content

- **Text** (bio, experience, publications, skills, contact): edit the corresponding file in
  [docs/](docs/) — they're plain Markdown.
- **CV**: replace [docs/assets/cv/CV_AdithyaMauryaKR.pdf](docs/assets/cv/CV_AdithyaMauryaKR.pdf)
  with the new PDF, keeping the same filename (or update the path in
  [docs/cv.md](docs/cv.md) if you rename it).
- **Colors**: all five palette colors are defined once at the top of
  [docs/stylesheets/extra.css](docs/stylesheets/extra.css).
- **Nav / pages**: add or reorder pages under `nav:` in [mkdocs.yml](mkdocs.yml).
