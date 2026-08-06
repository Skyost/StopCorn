# Website media

This tool runs both media pipelines and mirrors their generated files into the
Nuxt public directory:

- `tool/screenshots/outputs/store/` → `docs/public/screenshots/`;
- `tool/social/outputs/` → `docs/public/social/`;
- `assets/branding/logo.svg` → `tool/website/outputs/favicon.ico` →
  `docs/public/favicon.ico`.

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
`tool/website/outputs/` is ignored by Git, as are the other tools' output
directories and the mirrored generated media below `docs/public/`.
