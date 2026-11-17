// SPDX-FileCopyrightText: 2026 Krateos B.V.
// SPDX-License-Identifier: GPL-3.0-or-later

import Foundation

///
/// Decides which top-level pages an in-app web view may navigate to.
///
/// The privacy statement and the sign-in pages are part of the public website, whose header and footer link to
/// plans, pricing and sign-up. App Review (Guideline 3.1.1) treats such links as a call to action for purchase,
/// so the in-app web views are kept on a known set of pages (XEN-382, same fix as Xenia Notes in XEN-369).
///
/// Only main frame navigations are checked. Subframes (such as a CAPTCHA or consent widget) load freely, but
/// anything they try to open in the main frame is checked again, and new windows are never opened.
///
struct NCWebNavigationPolicy: Sendable, Equatable {
    enum Rule: Sendable, Equatable {
        case unrestricted
        case singlePage(host: String, path: String)
        case hosts(Set<String>, blockedPathFragments: [String])
    }

    let rule: Rule

    ///
    /// Every navigation is allowed. This matches the upstream behaviour.
    ///
    static let unrestricted = NCWebNavigationPolicy(rule: .unrestricted)

    ///
    /// Only the page at `url` may be shown: same host and path over HTTPS. Query and fragment are ignored,
    /// so anchors within the page still work. Every other link is blocked.
    ///
    static func singlePage(_ url: URL) -> NCWebNavigationPolicy {
        NCWebNavigationPolicy(rule: .singlePage(host: (url.host ?? "").lowercased(), path: normalized(path: url.path)))
    }

    ///
    /// Only HTTPS pages on the given hosts may be shown, except paths that contain any of `blockedPathFragments` (case insensitive).
    ///
    static func hosts(_ hosts: Set<String>, blockingPathsContaining blockedPathFragments: [String] = []) -> NCWebNavigationPolicy {
        NCWebNavigationPolicy(rule: .hosts(Set(hosts.map { $0.lowercased() }), blockedPathFragments: blockedPathFragments.map { $0.lowercased() }))
    }

    ///
    /// The policy for the login web view: the sign-in hosts from ``NCBrandOptions``, never the sign-up (enrollment) flow.
    ///
    static var login: NCWebNavigationPolicy {
        .hosts(NCBrandOptions.shared.loginAllowedHosts, blockingPathsContaining: NCBrandOptions.shared.loginBlockedPathFragments)
    }

    ///
    /// Whether a navigation to `url` is allowed.
    ///
    /// - Parameters:
    ///     - url: The navigation target.
    ///     - isMainFrame: `true` for the main frame, `false` for a subframe, `nil` when the target is a new window.
    ///
    func allows(_ url: URL?, isMainFrame: Bool?) -> Bool {
        if rule == .unrestricted {
            return true
        }

        switch isMainFrame {
        case .none:
            // New windows (target="_blank", window.open) are never opened.
            return false
        case .some(false):
            // Embedded frames may load; anything they open in the main frame is checked again.
            return true
        case .some(true):
            guard let url else {
                return false
            }

            return allowsMainFrame(url)
        }
    }

    private func allowsMainFrame(_ url: URL) -> Bool {
        switch rule {
        case .unrestricted:
            return true
        case let .singlePage(host, path):
            guard url.scheme?.lowercased() == "https", let urlHost = url.host?.lowercased() else {
                return false
            }

            return urlHost == host && Self.normalized(path: url.path) == path
        case let .hosts(hosts, blockedPathFragments):
            guard url.scheme?.lowercased() == "https", let urlHost = url.host?.lowercased(), hosts.contains(urlHost) else {
                return false
            }

            let urlPath = url.path.lowercased()
            return blockedPathFragments.allSatisfy { urlPath.contains($0) == false }
        }
    }

    private static func normalized(path: String) -> String {
        var path = path

        while path.count > 1, path.hasSuffix("/") {
            path.removeLast()
        }

        return path.isEmpty ? "/" : path
    }
}
