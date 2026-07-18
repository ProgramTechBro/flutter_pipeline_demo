# Flutter Pipeline Demo
 
A demo Flutter project built to learn and implement a complete, production-style CI/CD pipeline - the same kind of setup senior Flutter engineers build before shipping real apps at scale.
 
This isn't a feature-rich app on purpose. The focus is the pipeline and workflow around it: branching strategy, environment flavors, code quality gates, automated testing, Fastlane-driven builds, versioning, and signing - with CI/CD automation to follow in Phase 2.
 
## What the app does
 
A simple counter app with three small features, used as a working test case for the pipeline:
 
- Counter - increments a count
- Reset button - resets the count back to 0
- Dark mode toggle - switches between light/dark themes
- Displays the current environment (Development / Staging / Production) and its API URL on screen
## Branching strategy
 
- main - stable, production-ready code only
- develop - integration branch where all features are merged and tested before release
- feature/* - one branch per feature or pipeline step, merged into develop via pull request
Both main and develop are protected - direct pushes are disabled, all changes go through a pull request.
 
## Environments (Flavors)
 
The app supports three flavors, each with its own package name, app name, and isolated Firebase project.
 
| Flavor  | Package name suffix | Firebase app |
|---------|---------------------|--------------|
| dev     | .dev                 | Isolated dev Firebase app |
| staging | .staging             | Isolated staging Firebase app |
| prod    | none                 | Isolated production Firebase app |
 
Run a specific flavor:
 
```
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor staging -t lib/main_staging.dart
flutter run --flavor prod -t lib/main_prod.dart
```
 
## Code quality
 
- Lint rules enforced via very_good_analysis
- Formatting enforced via dart format
- Pre-commit hooks via Lefthook - commits are blocked automatically if formatting or analyzer checks fail
Run manually:
 
```
flutter analyze
dart format .
```
 
## Testing
 
Widget tests cover the app's core features (counter increment, reset, theme toggle).
 
```
flutter test
flutter test --coverage
```
 
## Build automation (Fastlane)
 
Fastlane lanes live in android/fastlane/Fastfile.
 
| Lane | What it does |
|------|---------------|
| bump_version | Auto-increments the build number in pubspec.yaml |
| beta | Bumps version, builds a debug APK for the dev flavor |
| release | Bumps version, builds a signed release APK for the dev flavor |
 
Run from the android folder:
 
```
cd android
fastlane beta
fastlane release
```
 
## Signing
 
Release builds are signed using a dedicated keystore, kept outside the repo and never committed.
 
- Keystore path and credentials are stored in android/key.properties - excluded from git via .gitignore
- Signing config is wired into android/app/build.gradle.kts and applied to the release build type
Note: key.properties and .jks / .keystore files are intentionally gitignored. You will need to generate your own keystore locally to build release APKs - see the setup guide below.
 
## Local setup
 
1. Clone the repo and install dependencies:
```
git clone <this-repo-url>
cd flutter_pipeline_demo
flutter pub get
```
 
2. Install Lefthook hooks:
```
lefthook install
```
 
3. Set up Firebase (requires FlutterFire CLI):
```
flutterfire configure --project=<your-firebase-project-id> --out=lib/firebase_options_dev.dart --android-package-name=com.example.flutter_pipeline_demo.dev
```
 
Repeat for staging and prod with their respective package names.
 
4. Generate a signing keystore for release builds:
```
keytool -genkey -v -keystore <path-to-keystore>.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
 
Then create android/key.properties with your keystore path and passwords. This file is never committed.
 
5. Run the app:
```
flutter run --flavor dev -t lib/main_dev.dart
```
 
## Project status
 
Phase 1 - Foundation and Local Automation: Complete
 
- Git strategy (branches, protection rules)
- Flavors and per-flavor Firebase setup
- Code quality gates (lint and pre-commit hooks)
- Testing baseline
- Fastlane install
- Versioning automation
- Signing setup
Phase 2 - CI/CD and Full Automation: In progress
 
- CI/CD platform setup (GitHub Actions or Codemagic)
- PR gate workflow (auto-run analyze, test, format)
- Auto-deploy to Firebase App Distribution, TestFlight, and Play Console
- Secrets management in CI
- Store metadata automation
- Notifications (Slack or Discord)
- Crash monitoring
- End-to-end dry run
## Notes
 
This project was built as a learning exercise, documenting real mistakes and fixes along the way rather than a polished, error-free process - including branch mix-ups, environment and keystore path issues, and JDK version conflicts, all resolved and documented as part of the process.
