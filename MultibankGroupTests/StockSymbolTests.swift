//
//  StockSymbolTests.swift
//  MultibankGroupTests
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Testing
@testable import MultibankGroup

struct StockSymbolTests {

    // MARK: - Price Change

    @Test func priceChangeUp() {
        let symbol = StockSymbol(id: "AAPL", name: "Apple", description: "", price: 150, previousPrice: 100)
        #expect(symbol.priceChange == .up)
    }

    @Test func priceChangeDown() {
        let symbol = StockSymbol(id: "AAPL", name: "Apple", description: "", price: 80, previousPrice: 100)
        #expect(symbol.priceChange == .down)
    }

    @Test func priceChangeUnchanged() {
        let symbol = StockSymbol(id: "AAPL", name: "Apple", description: "", price: 100, previousPrice: 100)
        #expect(symbol.priceChange == .unchanged)
    }

    @Test func priceChangeUpBySmallAmount() {
        let symbol = StockSymbol(id: "AAPL", name: "Apple", description: "", price: 100.01, previousPrice: 100.00)
        #expect(symbol.priceChange == .up)
    }

    // MARK: - All Symbols

    @Test func allSymbolsContains25Items() {
        #expect(StockSymbol.allSymbols.count == 25)
    }

    @Test func allSymbolsHaveUniqueIds() {
        let ids = StockSymbol.allSymbols.map(\.id)
        let uniqueIds = Set(ids)
        #expect(ids.count == uniqueIds.count)
    }

    @Test func allSymbolsHaveNonEmptyNames() {
        for symbol in StockSymbol.allSymbols {
            #expect(!symbol.name.isEmpty, "Symbol \(symbol.id) has an empty name")
        }
    }

    @Test func allSymbolsHaveNonEmptyDescriptions() {
        for symbol in StockSymbol.allSymbols {
            #expect(!symbol.description.isEmpty, "Symbol \(symbol.id) has an empty description")
        }
    }

    // MARK: - Identifiable & Hashable

    @Test func identifiableUsesIdAsIdentifier() {
        let symbol = StockSymbol(id: "TSLA", name: "Tesla", description: "", price: 200, previousPrice: 200)
        #expect(symbol.id == "TSLA")
    }

    @Test func hashableEquality() {
        let a = StockSymbol(id: "AAPL", name: "Apple", description: "desc", price: 150, previousPrice: 100)
        let b = StockSymbol(id: "AAPL", name: "Apple", description: "desc", price: 150, previousPrice: 100)
        #expect(a == b)
    }

    @Test func hashableInequality() {
        let a = StockSymbol(id: "AAPL", name: "Apple", description: "", price: 150, previousPrice: 100)
        let b = StockSymbol(id: "GOOG", name: "Google", description: "", price: 150, previousPrice: 100)
        #expect(a != b)
    }
}
