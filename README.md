# Chai

An app for the Chai Solutions capstone project for CSC-648.

## Getting Started

To get started, install [Flutter](https://flutter.dev) with your preferred
installation method.

When that is done, do the following:

1. `cp .env.template .env` (tweak the environment variables as needed)
2. `flutter run --dart-define-from-env=.env`.

Or use VSCode to run, which has this automatically configured.

**NOTE**: Android emulators will need to use `10.0.2.2` instead of `localhost`
or `127.0.0.1` for the `BASE_URL` variable for running the local server.

## Deployment

Deployment is done to App Store Connect and Google Play Console using
[Fastlane](https://fastlane.tools). For right now, it is done locally, and
requires a bit of setup. In the future, a continuous deployment pipeline using
GitHub Actions will be setup.

First, increment the build number (and version, if needed) in the `pubspec.yaml`.
Then, once this change is committed and pushed (**always** prefer to bump
versions in separate PRs!), then you can run the build command for each platform.

### Android

Android deployments to the internal testing track require a service account key
from the Chai Solutions organization to be present at
`android/fastlane/service-key.json`. Contact Varun (@water-sucks) for this
service account key.

An Android key store for signing is also required, as well as a file at
`android/key.properties` with the proper credentials for unlocking this key
store. Contact @water-sucks for this key store.

1. `flutter build appbundle --dart-define-from-env=.env`
2. `fastlane internal_testing` (inside `android/`)

### iOS

Uploading builds to TestFlight requires some extra configuration. Two
environment variables must be specified inside the file `ios/fastlane/.env`:

-   `FASTLANE_USER` :: the user the organization account is under (@water-sucks)
-   `FASTlANE_APPLE_APPLICATION_SPECIFIC_PASSWORD` :: credentials for authenticating
    to App Store Connect, generated with the app owner's account (@water-sucks)

The user that is building this must be part of the organization, and must open
Xcode at least once and check the signing configuration for the `Runner` target
to make sure this is the case.

Once this is configured, run the following:

1. `flutter build ipa --dart-define-from-env=.env`
2. `fastlane internal_testing` (inside `ios/`)
