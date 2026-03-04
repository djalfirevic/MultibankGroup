//
//  WebSocketServiceTests.swift
//  MultibankGroupTests
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Testing
@testable import MultibankGroup

struct WebSocketServiceTests {

    // MARK: - Initialization

    @Test func initialSymbolCount() {
        let service = WebSocketService()
        #expect(service.symbols.count == 25)
    }

    @Test func initialPricesArePositive() {
        let service = WebSocketService()
        for symbol in service.symbols {
            #expect(symbol.price > 0, "Symbol \(symbol.id) has non-positive initial price")
        }
    }

    @Test func initialPricesMatchPreviousPrices() {
        let service = WebSocketService()
        for symbol in service.symbols {
            #expect(symbol.price == symbol.previousPrice, "Symbol \(symbol.id) should have price == previousPrice initially")
        }
    }

    @Test func initiallyDisconnected() {
        let service = WebSocketService()
        #expect(service.isConnected == false)
    }

    // MARK: - Sorted Symbols

    @Test func sortedSymbolsDescendingByPrice() {
        let service = WebSocketService()
        let sorted = service.sortedSymbols
        for i in 0..<(sorted.count - 1) {
            #expect(sorted[i].price >= sorted[i + 1].price)
        }
    }

    @Test func sortedSymbolsContainsAllSymbols() {
        let service = WebSocketService()
        #expect(service.sortedSymbols.count == service.symbols.count)
    }

    // MARK: - Message Parsing

    @Test func parseValidMessage() {
        let result = WebSocketService.parseMessage("AAPL:150.25")
        #expect(result != nil)
        #expect(result?.symbolId == "AAPL")
        #expect(result?.price == 150.25)
    }

    @Test func parseMessageWithIntegerPrice() {
        let result = WebSocketService.parseMessage("GOOG:200")
        #expect(result != nil)
        #expect(result?.symbolId == "GOOG")
        #expect(result?.price == 200.0)
    }

    @Test func parseInvalidMessageNoColon() {
        let result = WebSocketService.parseMessage("AAPL150.25")
        #expect(result == nil)
    }

    @Test func parseInvalidMessageNonNumericPrice() {
        let result = WebSocketService.parseMessage("AAPL:abc")
        #expect(result == nil)
    }

    @Test func parseEmptyMessage() {
        let result = WebSocketService.parseMessage("")
        #expect(result == nil)
    }

    @Test func parseMessageWithMultipleColons() {
        let result = WebSocketService.parseMessage("AAPL:150:25")
        #expect(result == nil)
    }

    // MARK: - Apply Price Update

    @Test func applyPriceUpdateUpdatesPrice() {
        let service = WebSocketService()
        let symbolId = service.symbols[0].id
        let oldPrice = service.symbols[0].price

        service.applyPriceUpdate(symbolId: symbolId, price: 999.99)

        let updated = service.symbols.first { $0.id == symbolId }!
        #expect(updated.price == 999.99)
        #expect(updated.previousPrice == oldPrice)
    }

    @Test func applyPriceUpdateSetsPreviousPrice() {
        let service = WebSocketService()
        let symbolId = service.symbols[0].id

        service.applyPriceUpdate(symbolId: symbolId, price: 200.0)
        service.applyPriceUpdate(symbolId: symbolId, price: 300.0)

        let updated = service.symbols.first { $0.id == symbolId }!
        #expect(updated.price == 300.0)
        #expect(updated.previousPrice == 200.0)
    }

    @Test func applyPriceUpdateUnknownSymbolIsIgnored() {
        let service = WebSocketService()
        let originalSymbols = service.symbols

        service.applyPriceUpdate(symbolId: "UNKNOWN", price: 100.0)

        #expect(service.symbols == originalSymbols)
    }

    @Test func applyPriceUpdateMaintainsSortOrder() {
        let service = WebSocketService()

        service.applyPriceUpdate(symbolId: "AAPL", price: 10000.0)

        #expect(service.sortedSymbols.first?.id == "AAPL")
    }

    // MARK: - Connect / Disconnect

    @Test func disconnectSetsIsConnectedToFalse() {
        let service = WebSocketService()
        service.disconnect()
        #expect(service.isConnected == false)
    }
}
