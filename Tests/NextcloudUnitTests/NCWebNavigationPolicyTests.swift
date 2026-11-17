// SPDX-FileCopyrightText: 2026 Krateos B.V.
// SPDX-License-Identifier: GPL-3.0-or-later

import Foundation
import Testing
@testable import Nextcloud

///
/// The in-app web views must not reach plans, pricing or sign-up (App Review Guideline 3.1.1, XEN-382).
/// The blocked URLs are the links seen on the live privacy page and sign-in pages.
///
@Suite("Web Navigation Policy")
struct NCWebNavigationPolicyTests {
    private func url(_ string: String) throws -> URL {
        try #require(URL(string: string))
    }

    private func privacyPolicy() throws -> NCWebNavigationPolicy {
        .singlePage(try url(NCBrandOptions.shared.privacy))
    }

    // MARK: - Privacy statement (single page)

    @Test(arguments: [
        "https://xeniacloud.eu/privacy-statement-eu/",
        "https://xeniacloud.eu/privacy-statement-eu",
        "https://XENIACLOUD.eu/privacy-statement-eu/#cookies",
        "https://xeniacloud.eu/privacy-statement-eu/?lang=nl"
    ])
    func privacyAllowsTheStatement(_ string: String) throws {
        #expect(try privacyPolicy().allows(try url(string), isMainFrame: true))
    }

    @Test(arguments: [
        "https://xeniacloud.eu/",
        "https://xeniacloud.eu/#personal-pricing",
        "https://xeniacloud.eu/#business-pricing",
        "https://xeniacloud.eu/pricing-en/",
        "https://auth.xeniacloud.eu/if/flow/xenia-enrollment/",
        "https://xeniacloud.eu/privacy-policy/",
        "http://xeniacloud.eu/privacy-statement-eu/",
        "https://github.com/Krateos-BV/files-ios"
    ])
    func privacyBlocksEveryOtherPage(_ string: String) throws {
        #expect(try privacyPolicy().allows(try url(string), isMainFrame: true) == false)
    }

    @Test func privacyBlocksNewWindowsEvenForTheStatement() throws {
        #expect(try privacyPolicy().allows(try url(NCBrandOptions.shared.privacy), isMainFrame: nil) == false)
    }

    @Test func privacyAllowsSubframes() throws {
        #expect(try privacyPolicy().allows(try url("https://challenges.cloudflare.com/widget"), isMainFrame: false))
    }

    @Test func privacyBlocksMissingURL() throws {
        #expect(try privacyPolicy().allows(nil, isMainFrame: true) == false)
    }

    // MARK: - Login (sign-in hosts, no enrollment)

    @Test func loginAllowsTheLoginServer() throws {
        let login = try url(NCBrandOptions.shared.loginBaseUrl + "/index.php/login/v2/flow/token")
        #expect(NCWebNavigationPolicy.login.allows(login, isMainFrame: true))
    }

    @Test(arguments: [
        "https://auth.xeniacloud.eu/application/o/authorize/?client_id=x",
        "https://auth.xeniacloud.eu/if/flow/default-authentication-flow/"
    ])
    func loginAllowsSignInPages(_ string: String) throws {
        #expect(NCWebNavigationPolicy.login.allows(try url(string), isMainFrame: true))
    }

    @Test(arguments: [
        "https://auth.xeniacloud.eu/if/flow/xenia-enrollment/",
        "https://xeniacloud.eu/",
        "https://xeniacloud.eu/pricing-en/",
        "https://xeniacloud.eu/privacy-statement-eu/",
        "http://portal.xeniacloud.eu/login",
        "https://github.com/Krateos-BV/files-ios"
    ])
    func loginBlocksEverythingElse(_ string: String) throws {
        #expect(NCWebNavigationPolicy.login.allows(try url(string), isMainFrame: true) == false)
    }

    @Test func loginUsesTheRestrictedWebView() {
        #expect(NCBrandOptions.shared.use_restricted_login_web_view)
    }

    // MARK: - Settings

    @Test func sourceCodeRowIsHidden() {
        #expect(NCBrandOptions.shared.disable_source_code_in_settings)
    }

    @Test func unrestrictedAllowsEverything() throws {
        #expect(NCWebNavigationPolicy.unrestricted.allows(try url("https://xeniacloud.eu/pricing-en/"), isMainFrame: true))
        #expect(NCWebNavigationPolicy.unrestricted.allows(nil, isMainFrame: nil))
    }
}
