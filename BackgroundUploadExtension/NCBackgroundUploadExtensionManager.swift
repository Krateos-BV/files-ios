// SPDX-FileCopyrightText: Nextcloud GmbH
// SPDX-FileCopyrightText: 2026 Marino Faggiana
// SPDX-License-Identifier: GPL-3.0-or-later

import Foundation
import NextcloudKit

// XNT-229: The PhotosKit `PHBackgroundResourceUploadJobExtension` APIs this manager originally
// wrapped (PHAssetResourceUploadJobOptions, PHPhotoLibrary.enableUploadJobExtension, etc.) only
// exist in the Xcode 27 SDK, which no hosted GitHub Actions runner image carries. The
// BackgroundUploadExtension target and its scheme/build-phase embedding have been disabled so the
// main app can build on hosted runners again (see Jira XNT-229). This class previously lived
// behind `NCBrandOptions.shared.enable_background_upload_extension`, which already defaults to
// `false` for this brand (Brand/NCBrand.swift), so this stub is behavior-preserving for the
// current shipped configuration: callers already treated a `false`/no-op result as "feature
// unavailable, fall back to the existing BGTaskScheduler-based auto-upload path"
// (see iOSClient/Refresh/AppDelegate+AppRefresh.swift, iOSClient/Processor/AppDelegate+AppProcessing.swift,
// and NCAutoUpload.autoUploadBackgroundSync()).
//
// Capability lost while this stub is in place: true continuation of photo/file auto-upload after
// the app has been force-quit or fully suspended by iOS, and upload progress that is OS-managed
// by PhotosKit rather than opportunistically scheduled. The BGAppRefreshTask/BGProcessingTask path
// still provides best-effort background auto-upload while the app is merely backgrounded (not
// force-quit), but is throttled by the system and is not guaranteed to run on any fixed schedule.
//
// To restore the original behavior, revert this file and re-enable the BackgroundUploadExtension
// target's CopyFiles embedding in Nextcloud.xcodeproj/project.pbxproj on Xcode-27-only
// infrastructure.
final class NCBackgroundUploadExtensionManager {
    static let shared = NCBackgroundUploadExtensionManager()

    private init() {}

    func shouldUseExtension() async -> Bool {
        false
    }

    func ensureEnabled() async -> Bool {
        false
    }

    func disableIfIdle() async -> Bool {
        true
    }
}
