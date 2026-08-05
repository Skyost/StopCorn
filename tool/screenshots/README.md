# Store screenshots

StopCorn generates five deterministic screenshots for French and English on:

- Android phone (`1280 × 2856`)
- Android tablet (`1440 × 2560`)
- iPhone 6.9-inch (`1320 × 2868`)
- iPad 13-inch (`2064 × 2752`)

The Flutter test writes clean application captures to `screenshots/raw/`.
ImageMagick then creates localized store artwork in `screenshots/store/`, with
the same platform-compatible dimensions, a generated device mockup, a
scenario-specific logo or emoji, and captions from
`tool/screenshots/captions.json`. This catalog also controls whether each
device appears above or below its caption, its per-screenshot overflow and
horizontal offset, and the decorative background variation.

## Commands

Generate and process everything:

```bash
tool/screenshots/generate.sh
```

Generate only the raw application captures:

```bash
tool/screenshots/generate.sh --raw-only
```

Reprocess existing captures after changing captions or visual constants:

```bash
tool/screenshots/generate.sh --process-only
```

Each profile in `tool/screenshots/captions.json` has its own
`deviceOverflowPercent`. Use `0` to keep the corresponding device entirely
inside the canvas, or a value up to `20` to crop it progressively beyond the
top or bottom edge selected by `devicePlacement`.

Prerequisites are Flutter, Dart, Fontconfig, and ImageMagick 7 with the
`magick` executable and its Pango delegate. The repository-local fonts under
`tool/screenshots/fonts/` supply color emoji and the Lora Medium subtitle face
without needing a global installation. Their sources and OFL licenses are
documented in that folder. Titles use Noto Sans through Fontconfig. Set
`STOPCORN_SCREENSHOT_FONT` to a `.ttf` or `.otf` file to compare another
subtitle font.

To confirm that the ImageMagick installation supports color emoji rendering:

```bash
magick -list format | grep PANGO
```

For pixel-accurate iOS status-bar typography, install Apple's SF Pro fonts once
through `golden_screenshot` (the package otherwise falls back to Roboto):

```bash
dart run golden_screenshot:download_apple_fonts
```

The command downloads the fonts directly from Apple and must not be used to
redistribute or bundle them in the application.

Generated PNG files are intentionally ignored by Git. The scripts and caption
catalog are the reproducible source of truth.
