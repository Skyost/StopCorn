# Website media

This tool runs both media pipelines and mirrors their generated files into the
Nuxt public directory:

- `screenshots/store/` → `docs/public/screenshots/`;
- `social/generated/` → `docs/public/social/`;
- `assets/branding/logo.svg` → a multi-resolution `docs/public/favicon.ico`.

Generate fresh Flutter captures, store artwork, and social images with:

```bash
tool/website/generate.sh
```

To reuse existing raw Flutter captures while reprocessing all website media:

```bash
tool/website/generate.sh --process-only
```

The two destination directories are fully managed by this tool and replaced on
each run, preventing removed or renamed source images from lingering in Nuxt.
