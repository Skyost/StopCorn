# App and store icons

All StopCorn icons are rendered directly from the tracked vector logo at
`assets/branding/logo.svg`. Never upscale one of the small Android launcher
PNGs for a store listing.

Generate every Android launcher icon, every iOS asset-catalog icon, and both
store assets from the repository root:

```sh
./tool/icons/generate.sh
```

Generate only the two store assets:

```sh
./tool/icons/generate.sh --store-only
```

The script requires ImageMagick with SVG support. It checks the dimensions,
color space, alpha-channel rule, and Google Play file-size limit before it
finishes.

## Store outputs

| File                                      | Purpose                                              | Generated properties                                               |
|-------------------------------------------|------------------------------------------------------|--------------------------------------------------------------------|
| `tool/icons/outputs/app-store-icon.png`   | Reference copy of the icon embedded in the iOS build | 1024 × 1024, sRGB PNG, no alpha channel                            |
| `tool/icons/outputs/google-play-icon.png` | Upload in the Google Play store listing              | 512 × 512, 32-bit sRGB PNG, opaque alpha channel, at most 1,024 KB |

Apple obtains the App Store icon from the iOS asset catalog when the build is
uploaded. The generator therefore copies the standalone Apple output to the
1024 × 1024 marketing slot in
`ios/Runner/Assets.xcassets/AppIcon.appiconset/`; both files contain identical
pixels.

The store files deliberately have square edges and no drop shadow. Apple and
Google apply their own masks, rounded corners, and presentation effects.

`tool/icons/outputs/` is ignored by Git because every file in it is generated
from the tracked SVG and generator. Run the command again whenever a fresh
upload asset is needed.
