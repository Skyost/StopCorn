# Social artwork

The social image generator creates two deterministic PNG files:

- `open-graph.png` (`1200 × 630`) for Open Graph previews;
- `twitter.png` (`1024 × 1024`) for Twitter/X summary cards.

Both reuse the gradient, decorative shapes, palette, logo, and title treatment
of the store artwork. Generate them with:

```bash
tool/social/generate.sh
```

The PNG files are written to `tool/social/outputs/` and intentionally ignored
by Git. ImageMagick 7 with its Pango delegate is required.
