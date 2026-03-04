//
//  AppRouteTests.swift
//  MultibankGroupTests
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Testing
@testable import MultibankGroup

struct AppRouteTests {

    // MARK: - Identifiable

    @Test func feedRouteId() {
        let route = AppRoute.feed
        #expect(route.id == "feed")
    }

    @Test func symbolDetailRouteId() {
        let route = AppRoute.symbolDetail(symbolId: "AAPL")
        #expect(route.id == "symbolDetail-AAPL")
    }

    @Test func differentSymbolsHaveDifferentIds() {
        let a = AppRoute.symbolDetail(symbolId: "AAPL")
        let b = AppRoute.symbolDetail(symbolId: "GOOG")
        #expect(a.id != b.id)
    }

    // MARK: - Hashable

    @Test func feedRoutesAreEqual() {
        #expect(AppRoute.feed == AppRoute.feed)
    }

    @Test func sameSymbolDetailRoutesAreEqual() {
        let a = AppRoute.symbolDetail(symbolId: "TSLA")
        let b = AppRoute.symbolDetail(symbolId: "TSLA")
        #expect(a == b)
    }

    @Test func differentRoutesAreNotEqual() {
        let a = AppRoute.feed
        let b = AppRoute.symbolDetail(symbolId: "AAPL")
        #expect(a != b)
    }
}
