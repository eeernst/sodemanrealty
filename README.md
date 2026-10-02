# Sodeman Realty (Static Site)

Tech: Eleventy (11ty) + Nunjucks + vanilla CSS/JS. Deploy: GitHub Pages via Actions.

Site source lives in `docs/`.

## Local dev
```bash
cd docs
npm i
npm run dev
```

## Build
```bash
cd docs
npm run build
```

Output is in `docs/dist/`.

## Update content
- Site config: `docs/src/_data/site.json`
- Featured listings: `docs/src/_data/listings.json` (`items` array)
- Pages: `docs/src/*.njk`
- Blog posts: `docs/src/blog/*.md`
- Assets: `docs/src/assets/**`

## Joel intake
Open questions and assets to collect from Joel are tracked in `JOEL-INTAKE.md` (do not invent answers).
