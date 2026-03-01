# Sodeman Realty (Static Site)

Tech: Eleventy (11ty) + Nunjucks + vanilla CSS/JS. Deploy: GitHub Pages via Actions.

## Local dev
```bash
npm i
npm run dev
```

## Build
```bash
npm run build
```

Output is in `dist/`.

## Update content
- Site config: `src/_data/site.json`
- Pages: `src/*.njk`
- Blog posts: `src/blog/*.md` (monthly cadence)
- Assets: `src/assets/**`

## Replace placeholders
- `src/assets/img/joel-headshot.jpg` (included)
- Featured listing URLs: update `src/index.njk` and `src/listings.njk`
