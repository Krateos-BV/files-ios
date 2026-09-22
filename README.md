# Xenia Files

[![REUSE status](https://api.reuse.software/badge/github.com/Krateos-BV/files-ios)](https://api.reuse.software/info/github.com/Krateos-BV/files-ios)

> Independently maintained iOS client for Xenia Files, based on the [Nextcloud iOS app](https://github.com/nextcloud/ios) (GPLv3, with the Apple App Store exception below). Not affiliated with or endorsed by Nextcloud GmbH.

**The iOS client for [XeniaCloud](https://xeniacloud.eu). Easily work with your data on your XeniaCloud account.**

## Getting help

This is an independently maintained fork — the upstream Nextcloud community channels, forum, and issue tracker are for the Nextcloud app, not Xenia Files, and won't be able to help with anything specific to this fork or to a XeniaCloud account. For support with Xenia Files or your XeniaCloud account, contact XeniaCloud support directly.

Keep in mind that this repository only manages the iOS app. Server/backend issues should go through XeniaCloud support, not the Nextcloud project.

## Development version

This fork is not currently distributed via the App Store, TestFlight, or GitHub Releases. Builds are produced by this repository's own CI (`xenia-ci.yml`) as unsigned artifacts.

## Development setup

### Dependencies

In order to build the project in Xcode you will also need a file `GoogleService-Info.plist` at the root of the repository which contains the Firebase configuration. For development work you can use a mock version found [here](https://github.com/firebase/quickstart-ios/blob/master/mock-GoogleService-Info.plist).

## Upstream & license

Xenia Files is a rebrand of [nextcloud/ios](https://github.com/nextcloud/ios), forked under its [GPLv3 license, with an Apple App Store exception](COPYING.iOS), which permits forking provided Nextcloud's own trademarks and branding are not carried over — the app name, icon, splash screen and accent colors are being changed accordingly as that work lands; the underlying code and functionality are otherwise unchanged from upstream unless noted in this fork's own commit history.
