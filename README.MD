## What is it

Dockerfile to generate a Docker image to develop with the [Dart Language](https://www.dartlang.org/) stack:

- Dart VM
- Flutter
- AngularDart

The aim of this Docker image is to use it on some CI/CD solution, like [Jenkins](https://jenkins.io/) or [CircleCI](https://circleci.com/).
There are no IDEs inside this image.

## Content

### Dart
- v2 from [dev channel](https://www.dartlang.org/tools/sdk#install-using-apt-get)

### Flutter
- v0.4.4-beta

### Android SDK
- platform-tools
- build-tools;26.0.3
- platforms;android-27
- emulator
- extras;android;m2repository
- extras;google;m2repository

### Android Virtual Device
Name:         test_27_x8
SDK pakcage:  system-images;android-27;google_apis;x86
Derived from: "pixel"

