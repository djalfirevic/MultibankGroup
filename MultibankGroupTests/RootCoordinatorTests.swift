//
//  RootCoordinatorTests.swift
//  MultibankGroupTests
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Foundation
import SwiftUI
import Testing
@testable import MultibankGroup

struct RootCoordinatorTests {

    // MARK: - Initialization

    @Test func initialRouteIsFeed() {
        let coordinator = RootCoordinator(service: WebSocketService())
        #expect(coordinator.router.root == .feed)
        #expect(coordinator.router.path.count == 0)
    }

    // MARK: - Deep Link

    @Test func validDeepLinkPushesSymbolDetail() {
        let coordinator = RootCoordinator(service: WebSocketService())
        let url = URL(string: "stocks://symbol/aapl")!
        coordinator.handleDeepLink(url)
        #expect(coordinator.router.path.count == 1)
    }

    @Test func deepLinkUppercasesSymbolId() {
        let coordinator = RootCoordinator(service: WebSocketService())
        let url = URL(string: "stocks://symbol/nvda")!
        coordinator.handleDeepLink(url)
        #expect(coordinator.router.path.count == 1)
    }

    @Test func invalidSchemeIsIgnored() {
        let coordinator = RootCoordinator(service: WebSocketService())
        let url = URL(string: "http://symbol/AAPL")!
        coordinator.handleDeepLink(url)
        #expect(coordinator.router.path.count == 0)
    }

    @Test func invalidHostIsIgnored() {
        let coordinator = RootCoordinator(service: WebSocketService())
        let url = URL(string: "stocks://other/AAPL")!
        coordinator.handleDeepLink(url)
        #expect(coordinator.router.path.count == 0)
    }

    @Test func missingSymbolIsIgnored() {
        let coordinator = RootCoordinator(service: WebSocketService())
        let url = URL(string: "stocks://symbol/")!
        coordinator.handleDeepLink(url)
        #expect(coordinator.router.path.count == 0)
    }
}
