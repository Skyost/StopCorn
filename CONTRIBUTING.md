# Contributing to StopCorn

Thanks for taking the time to contribute. StopCorn is a private, local-first,
and judgment-free self-help application. Contributions that preserve those
principles are especially welcome.

> [!IMPORTANT]
> GitHub issues and pull requests are public. Never include intimate notes,
> personal histories, exports, API keys, unredacted logs, or screenshots that
> reveal personal information or explicit material.

## Before you start

- Search [existing issues] before opening a new one.
- Use the relevant issue form for a bug, feature idea, or documentation and
  website change.
- For a substantial feature, open an issue and wait for maintainer feedback
  before investing significant implementation time. This helps keep StopCorn
  focused, private, and maintainable.
- Keep each pull request limited to one focused change.

## Reporting bugs

Please use the [bug-report form]. Include reproducible steps, the StopCorn and
operating-system versions, and the expected and actual behaviour. Sanitized
logs or redacted screenshots are welcome when they help; do not attach private
application data.

If you plan to fix a reported bug, leave a comment on the issue first. A pull
request that fixes an issue should include `Fixes #123` in its description and
a regression test when practical.

## Suggesting features

Use the [feature-request form] to describe the user need, proposed solution,
alternatives, and privacy implications. Please avoid requests that introduce
tracking, advertising, mandatory accounts, browsing monitoring, or collection
of sensitive data unless their privacy trade-offs have been discussed first.

## Development setup

### Mobile application

Install Flutter 3.44.8 stable (or a compatible Flutter/Dart release) and the
Android or iOS toolchain for the platform you intend to run. Then, from the
repository root:

```sh
flutter pub get
dart run build_runner build
flutter run
```

Optional RevenueCat and Sentry integrations are configured through a local
`.env` file; empty values disable them. Do not commit this file or generated
environment code.

### Website

The static bilingual website is in `docs/`. It requires Node.js 22.19 or newer
and pnpm 11:

```sh
cd docs
pnpm install
pnpm dev
```

See [`docs/README.md`](docs/README.md) for website content and generated-media
details.

## Making changes

1. Fork the repository and create a branch from `main`.
2. Make the smallest change that solves the issue.
3. Keep user-facing text respectful, supportive, and free of moral judgment.
4. Preserve the local-first model: do not add network access, analytics,
   permissions, or persistent sensitive data without clearly documenting and
   discussing the need.
5. Add or update tests and documentation when the behaviour changes.
6. Regenerate generated files when necessary; do not edit generated files by
   hand.

### Localization

English is the base locale and French is also supported. Changes to user-facing
copy normally require matching updates under both `lib/i18n/en/` and
`lib/i18n/fr/`, followed by:

```sh
dart run build_runner build
```

Do not edit generated `strings*.g.dart` files manually.

### Data and schema changes

Before the first public release, keep `AppConstants.databaseSchemaVersion` at
`1`, update the initial Drift schema directly, regenerate code, and test the
version-1 database. After the first release, every schema change must preserve
existing user data and include migrations from all supported released versions.

## Checks before opening a pull request

Run the checks relevant to your change. For mobile-app changes, run:

```sh
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

For website changes, run:

```sh
pnpm --dir docs check
```

If you cannot run a check, explain why in the pull request. Generated website
media and screenshots are intentionally ignored; use the documented tooling
when a change requires refreshing them.

## Pull requests

Use a clear title following the Conventional Commits format. Common prefixes
are `fix:`, `feat:`, `docs:`, `test:`, `refactor:`, `perf:`, `build:`, `ci:`,
and `chore:`. Mark breaking changes with `!`, for example `feat!: change export
format`.

In the description, explain what changed, why it is needed, how it was tested,
and any privacy, accessibility, or localization considerations. Link the
related issue where applicable. Maintainers may request changes to keep the
application consistent, safe, and focused.

[existing issues]: https://github.com/Skyost/StopCorn/issues
[bug-report form]: https://github.com/Skyost/StopCorn/issues/new?template=bug_report.yml
[feature-request form]: https://github.com/Skyost/StopCorn/issues/new?template=feature_request.yml
