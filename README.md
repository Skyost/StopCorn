<p align="center">
  <img src="assets/branding/logo.svg" width="132" alt="StopCorn corn-cob logo">
</p>

<h1 align="center">StopCorn</h1>

<p align="center">
  <strong>Take back control, at your pace.</strong><br>
  A private, judgment-free companion for understanding or changing <em>cornography</em> use.
</p>

<p align="center">
  <img alt="Flutter 3.44" src="https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter&logoColor=white">
  <img alt="Android and iOS" src="https://img.shields.io/badge/platforms-Android%20%7C%20iOS-4E6851">
  <img alt="Free and without ads" src="https://img.shields.io/badge/free-no%20ads-E8A03A">
  <img alt="Available in English and French" src="https://img.shields.io/badge/languages-EN%20%7C%20FR-6B5FA7">
</p>

<p align="center">
  <a href="https://stopcorn.skyost.eu/en/">Website</a> ·
  <a href="https://github.com/Skyost/StopCorn/releases">Releases</a> ·
  <a href="https://github.com/Skyost/StopCorn/issues">Feedback</a>
</p>

StopCorn helps adults create some distance between an urge and a decision,
notice patterns without shame, and make progress toward a goal they choose for
themselves. There is no account, no feed, no advertising, and no monitoring of
browsing activity. The information entered in the app stays on the device by
default.

> [!IMPORTANT]
> StopCorn is a self-help and self-observation tool. It is not a medical device,
> diagnosis, or treatment. If distress or loss of control persists, support
> from a qualified professional may be helpful.

## Why people may find it useful

- **Immediate support when an urge appears.** Choose a guided pause, launch a
  personal backup-plan action, or try another concrete idea.
- **Goals that fit real life.** Start with observation, reduction, abstinence,
  or contexts you specifically want to protect.
- **A journal without moral scoring.** Bring voluntary events, completed support
  sessions, check-ins, general contexts, and private notes into one timeline.
- **Descriptive progress, not promises.** Explore trends, helpful strategies,
  check-in markers, and the active goal while keeping missing data in context.
- **Short offline learning modules.** Nine bilingual modules explain urges,
  habits, shame, environments, emotions, self-monitoring, setbacks, and
  sustainable change, each with per-section takeaways and cited sources.
- **Optional encouragement.** A non-punitive daily “harvest” recognizes useful
  actions without turning abstinence into a competition.

Everything important remains available for free. Optional financial support
does not unlock essential features.

## A look inside

<p align="center">
  <img src="https://stopcorn.skyost.eu/screenshots/en/ios/iphone/1_home.png" width="18%" alt="StopCorn home screen">
  <img src="https://stopcorn.skyost.eu/screenshots/en/ios/iphone/2_urge_support.png" width="18%" alt="StopCorn urge-support flow">
  <img src="https://stopcorn.skyost.eu/screenshots/en/ios/iphone/3_progress.png" width="18%" alt="StopCorn progress dashboard">
  <img src="https://stopcorn.skyost.eu/screenshots/en/ios/iphone/4_journal.png" width="18%" alt="StopCorn private journal">
  <img src="https://stopcorn.skyost.eu/screenshots/en/ios/iphone/5_learning.png" width="18%" alt="StopCorn offline learning library">
</p>

<p align="center">
  <sub>Home · Urge support · Progress · Journal · Learn</sub>
</p>

The screenshot files are intentionally not committed: the website pipeline
generates them from deterministic Flutter widget tests, processes them, and
publishes them under the stable URLs used above. The app and this README share
the tracked logo at [`assets/branding/logo.svg`](assets/branding/logo.svg).

## Private by design

- No StopCorn account or remote journal synchronization.
- No advertising, audience analytics, or behavioral-tracking SDK.
- Anonymous crash reports are sent through Sentry so failures can be fixed.
  They carry the technical error and where it happened, never a goal, journal
  record, note, or database value, and a switch in Settings turns them off
  completely.
- No URL, search, browsing-history, screenshot, contact, location, or network
  traffic collection.
- Optional daily reminders are scheduled entirely on the device and contain no
  check-in data.
- Nothing reaches RevenueCat until the optional support paywall is opened
  deliberately: displaying Settings stays local. Once it has been opened, the
  supporter entitlement is checked on later launches so a purchase can be
  acknowledged. Opening the paywall also involves the device's app store;
  StopCorn never attaches journal content or private notes.

> [!NOTE]
> Exports are not encrypted yet.
> Device system backups may include app data depending on platform settings.


## Getting StopCorn

Official App Store and Google Play links have not been published yet. Follow
[GitHub Releases](https://github.com/Skyost/StopCorn/releases) or the
[project website](https://stopcorn.skyost.eu/en/#download) for availability.
Developers can already run the complete application from source.

## Run it from source

### Requirements

- At least Flutter 3.44 stable, or a compatible release;
- at least Dart 3.12, or a version allowed by `pubspec.yaml`;
- the Android or iOS toolchain for the target platform.

Check the local environment:

```sh
flutter doctor
flutter --version
```

Install dependencies:

```sh
flutter pub get
```

Create `.env`. Empty values simply disable the feature they belong to: no
support paywall without a RevenueCat key, and no crash reporting without a
Sentry DSN.

```dotenv
REVENUECAT_ANDROID_API_KEY=
REVENUECAT_IOS_API_KEY=
REVENUECAT_TEST_API_KEY=
SENTRY_DSN=
```

Generate translations and source code, then run the app:

```sh
dart run build_runner build
flutter run
```

Android builds use `android/key.properties`, which is intentionally excluded
from version control. Create it before building, including for a debug build:

```properties
storeFile=/absolute/path/to/stopcorn.jks
storePassword=…
keyAlias=…
keyPassword=…
```

## Quality checks

```sh
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

Tests use an in-memory Drift database and isolated preferences. They cover the
onboarding flow, reminder scheduling, all support paths, journaling, contextual
goals, check-ins, progress statistics, learning, sample data, export, complete
deletion, repository failures, crash-report scrubbing, enlarged text, and narrow
layouts.

## Project structure

StopCorn is a feature-first Flutter application:

```text
lib/
  app/                 startup, routing, theme, shared widgets
  core/                database, preferences, diagnostics, constants, time
  features/
    onboarding/
    home/
    urge/
    journal/
    consumption/
    check_in/
    goals/
    progress/
    harvest/
    learning/
    settings/
    data_export/
  i18n/                English and French source translations
assets/
  branding/            shared tracked logo
  learning/            offline module catalog and descriptors
docs/                   bilingual static Nuxt website
tool/                   artwork, screenshot, website, and audit tooling
```

Presentation widgets communicate with generated Riverpod controllers.
Controllers use repositories and services; widgets do not access storage
directly. The main dependencies are:

- ForUI and low-level Flutter widgets for the interface;
- `go_router` for navigation and onboarding redirects;
- Riverpod code generation for state and dependency injection;
- Drift for relational and queryable local history;
- `SharedPreferencesAsync` for simple StopCorn-owned preferences;
- Slang for typed English and French localization;
- `flutter_local_notifications`, `flutter_timezone`, and `timezone` for
  daylight-saving-safe local reminders;
- RevenueCat Purchases and Paywalls for optional project support;
- Sentry for anonymous, scrubbed, and disableable crash reports;
- Nuxt, TypeScript, and Bootstrap Vue Next for the static bilingual website.

## Optional RevenueCat support

The support card in Settings always exposes the project website and source
repository, and it does so without any network call: RevenueCat is not
configured, and no entitlement is read, as long as nobody presses the support
button. That button is the explicit opt-in. It stores the
`project_support_checks_enabled` preference, presents the current RevenueCat
Offering with its attached Paywall, and from then on the anonymous supporter
entitlement is checked when Settings opens, so an earlier purchase is still
acknowledged on the next launch. Complete deletion clears that preference along
with the rest, which returns the application to its offline default.

RevenueCat Paywalls require Android API 24 or newer. On iOS, the native paywall
is available from iOS 15. Create the apps, products, Offering, and Paywall in
RevenueCat, then add the public SDK keys to `.env`:

```dotenv
REVENUECAT_ANDROID_API_KEY=your_google_public_key
REVENUECAT_IOS_API_KEY=your_apple_public_key
REVENUECAT_TEST_API_KEY=your_test_store_public_key
```

Envied reads these values during code generation and writes
`lib/core/env/env.g.dart`. Regenerate after a change:

```sh
dart run build_runner build
```

Release builds deliberately ignore the Test Store key and select the public key
for the target platform. Never generate a release with a Test Store key. The
public SDK keys are not secret server credentials, but `.env` and generated
environment code remain outside version control. Without a matching key,
StopCorn stays fully usable and shows a localized configuration message.

StopCorn disables RevenueCat diagnostics and advertising-identifier collection.
The SDK is initialized the first time someone opens the support paywall, and on
later launches only if that already happened; the app does not send goals,
journal records, notes, or browsing data with that status check or with a
purchase.

## Crash reporting

Crashes are reported to Sentry so they can be fixed, and reporting is on by
default. Anyone can stop it entirely with **Settings → Data → Anonymous crash
reports**; the choice applies to the next report, not to the next launch, and a
declined choice means Sentry is never initialized at startup at all.

Two conditions gate reporting before the preference is even consulted, in
`canReportErrors`: debug builds never report, and neither does a build without
`SENTRY_DSN`, so running from source and forks stay completely offline.

What leaves the device is deliberately narrow, and
`lib/core/diagnostics/sentry_privacy.dart` is the single place that defines it:

- no personal information, screenshots, session data, or performance traces;
- navigation breadcrumbs keep the location path and drop its query string,
  because a StopCorn location can carry an event identifier or a check-in date;
- database exception messages are replaced by their error code, since a failed
  statement can quote the values it tried to write, and those values are notes
  and reflections;
- handled failures are reported with a stable operation key such as
  `check_in.save`, never with the record that failed.

`test/core/diagnostics/sentry_privacy_test.dart` locks that behavior down.

## Local data model

Drift stores history and relationships:

- goals, including weekly limits and protected contexts;
- urge sessions and strategies used;
- voluntarily recorded consumption events and their selected goal contexts;
- daily check-ins and self-assessments;
- learning progress;
- the resumable onboarding draft.

`SharedPreferencesAsync` stores simple settings such as onboarding completion,
theme, language, selected backup-plan strategies, reminder state, progress
period, optional harvest visibility, whether the optional supporter status may
be checked online, and whether crash reports may be sent. Preference keys are
allow-listed.
Complete deletion clears StopCorn data, cached exports, and preferences, then
reseeds only the built-in strategies needed for a fresh launch.

## Localization

English is the base and fallback locale; French is also supported. Translation
sources are split by namespace under `lib/i18n/en/` and `lib/i18n/fr/`. Update
the same key in both locales and run:

```sh
dart run build_runner build
```

Generated `strings*.g.dart` files must not be edited manually. Quantity-aware
copy uses Slang cardinal forms. English normally resolves zero through `other`;
French requires explicit `zero` forms anywhere `0` would otherwise use the
singular. `test/i18n/pluralization_test.dart` locks this behavior down.

Learning-module descriptors contain stable identifiers, order, translation
keys, and references. Each section lists its paragraph keys and may add optional
`keyPointKeys` rendered as takeaways. Reader-facing copy lives in one Slang JSON
file per module and locale. When the bundled catalog changes, increment both its
`contentVersion` and `AppConstants.learningContentVersion`.

Reading duration is not stored: `learning_reading_time.dart` derives it from the
word count of the translated sections, so each locale reports its own estimate
and the figure can never drift away from the copy.

Every reference must be a real, verifiable record: the citation carries a
resolvable DOI and the `url` points to its PubMed entry, or to `doi.org` when
the work is not indexed there. `test/features/learning/learning_repository_test.dart`
pins the audited list.

## Website and generated media

The static site lives in `docs/` and requires Node.js 22.19+ with pnpm 11:

```sh
cd docs
pnpm install
pnpm check
```

From the repository root, this command generates localized Flutter screenshots
and social artwork, then synchronizes them into the site's ignored public media
directories:

```sh
tool/website/generate.sh
```

Use `tool/website/generate.sh --process-only` to reuse existing raw captures.
The site deploys English at `/en/`, French at `/fr/`, screenshots under
`/screenshots/`, and social previews under `/social/`.

Launcher icons are generated from the tracked SVG logo and the tokens in
`tool/artwork/brand_artwork.dart`:

```sh
./tool/icons/generate.sh
```

This requires ImageMagick with SVG support. The Android notification icon is a
hand-written vector and is not regenerated.

## Contributing and feedback

Bug reports and feature ideas are welcome in
[GitHub Issues](https://github.com/Skyost/StopCorn/issues). Issues are public:
never include intimate notes, personal history, exported data, or other
sensitive information.
