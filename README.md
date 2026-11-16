# Xenia Files

[![REUSE status](https://api.reuse.software/badge/github.com/Krateos-BV/files-ios)](https://api.reuse.software/info/github.com/Krateos-BV/files-ios)

> Independently maintained iOS client for Xenia Files, based on the [Nextcloud iOS app](https://github.com/nextcloud/ios) (GPLv3, with the Apple App Store exception below). Not affiliated with or endorsed by Nextcloud GmbH.

**The iOS client for [XeniaCloud](https://xeniacloud.eu). Easily work with your data on your XeniaCloud account.**

## Getting help

This is an independently maintained fork — the upstream Nextcloud community channels, forum, and issue tracker are for the Nextcloud app, not Xenia Files, and won't be able to help with anything specific to this fork or to a XeniaCloud account. For support with Xenia Files or your XeniaCloud account, contact XeniaCloud support directly.

Keep in mind that this repository only manages the iOS app. Server/backend issues should go through XeniaCloud support, not the Nextcloud project.

## Development version

<<<<<<< HEAD
This fork is not currently distributed via the App Store, TestFlight, or GitHub Releases. Builds are produced by this repository's own CI (`xenia-ci.yml`) as unsigned artifacts.

## Development setup
=======
Nextcloud doesn't require a CLA (Contributor License Agreement). The copyright belongs to all the individual contributors. Use SPDX headers for source files, preserving existing contributor credits and adding your own when making substantial changes:

```
// SPDX-FileCopyrightText: Nextcloud GmbH
// SPDX-FileCopyrightText: <year> <your name>
// SPDX-License-Identifier: GPL-3.0-or-later
```
>>>>>>> upstream/master

### Dependencies

All dependencies are Swift Packages declared in `Nextcloud.xcodeproj` and resolve automatically when the project is opened in Xcode. Xenia Files does not include the Firebase SDKs, so no `GoogleService-Info.plist` is needed.

## Upstream & license

<<<<<<< HEAD
Xenia Files is a rebrand of [nextcloud/ios](https://github.com/nextcloud/ios), forked under its [GPLv3 license, with an Apple App Store exception](COPYING.iOS), which permits forking provided Nextcloud's own trademarks and branding are not carried over — the app name, icon, splash screen and accent colors are being changed accordingly as that work lands; the underlying code and functionality are otherwise unchanged from upstream unless noted in this fork's own commit history.
=======
You can start by forking this repository and creating pull requests on the develop
branch. Maybe start working on [starter issues](https://github.com/nextcloud/ios/labels/good%20first%20issue). 

Easy starting points are also reviewing [pull requests](https://github.com/nextcloud/ios/pulls)

### Xcode 27.2 Project Setup

Open `Nextcloud.xcodeproj`; package dependencies are managed by Swift Package Manager. The CI toolchain and simulator destination are defined in [.github/workflows/xcode.yml](.github/workflows/xcode.yml) (currently Xcode 27.1 and iPhone 17 with iOS 27.0).

#### Dependencies

In order to build the project in Xcode you will also need a file `GoogleService-Info.plist` at the root of the repository which contains the Firebase configuration. For development work you can use a mock version found [here](https://github.com/firebase/quickstart-ios/blob/master/mock-GoogleService-Info.plist).

### Creating Pull requests

#### DCO Signoff

Nextcloud enforces the [Developer Certificate of Origin (DCO)](https://developercertificate.org/) on Pull Requests. It requires your commit messages to contain a Signed-off-by line with an email address that matches your GitHub account.

##### How to Sign off

The DCO is a way for contributors to certify that they wrote or otherwise have the right to submit the code they are contributing by adding a Signed-off-by line to commit messages.

```
My Commit message

Signed-off-by: Random Contributor <random@contributor.dev>
```

Git even has a `-s | --signoff` command line option to append this to your commit messages automatically.

## Support

If you need assistance or want to ask a question about the iOS app, you are welcome to [ask for support](https://help.nextcloud.com/c/clients/ios) in our Forums. If you have found a bug, feel free to [open a new Issue on GitHub](https://github.com/nextcloud/ios/issues). Keep in mind, that this repository only manages the iOS app. If you find bugs or have problems with the server/backend, you should ask the [Nextcloud server team](https://github.com/nextcloud/server) for help!

## TestFlight 

Do you want to try the latest version in development of Nextcloud iOS ? Simple, follow this simple step

[Apple TestFlight](https://testflight.apple.com/join/RXEJbWj9)

## Testing

**Note: If a unit or integration test exclusively uses and tests NextcloudKit functions and components, then add that test to the NextcloudKit project instead. NextcloudKit is used in many other projects as an API, and it's better if such tests are located there.**

### Unit Tests

There are currently no prerequisites for unit testing.
Mock everything which is not needed. 

### Integration Tests

Configure the server URL and credentials in [Tests/TestConstants.swift](Tests/TestConstants.swift). The defaults are `http://localhost:8080` and `admin` / `admin`, matching CI.
Local tests use the [shallow CI server image](https://github.com/nextcloud/docker-ci/pkgs/container/continuous-integration-shallow-server) through the Docker script below. GitHub Actions instead installs Nextcloud directly on the runner and serves it on port 8080 using PHP. Both currently use the `stable30` server branch.

Currently, you still need to launch the server manually once before running any tests locally.
This project comes with a convenience script to do so, see or run [Tests/Server.sh](Tests/Server.sh).
**Please familiarize yourself with its content before running it** to avoid unintended removal of a container named like in the script. 

The same instance is reused for all tests.
A long term goal is to automatically create and discard container _per test_ to ensure maximum test isolation and a clean test environment.
Note that plain HTTP is used in this case to circumvent certificate issues and simplify the sign-in flow in automation.

### UI Tests

UI tests also require a Nextcloud server to test against just like integration tests.
**Important**: Additionally, UI tests assume your test device (regardless whether physical or Simulator) is set to **US English**.
This is required because in some parts of the user interface the automation has no other choice than to rely on localized texts for control.
>>>>>>> upstream/master
