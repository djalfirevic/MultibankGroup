//
//  WebSocketService.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Foundation
import Combine

final class WebSocketService: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isConnected = false
    @Published private(set) var symbols: [StockSymbol] = StockSymbol.allSymbols

    var sortedSymbols: [StockSymbol] {
        symbols.sorted { $0.price > $1.price }
    }
    private var webSocketTask: URLSessionWebSocketTask?
    private var timer: AnyCancellable?
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    private let session: URLSession
    private var pendingUpdates: [String: Double] = [:]

    // MARK: - Initialization

    init() {
        session = URLSession(configuration: .default)
        initializePrices()
    }

    deinit {
        disconnect()
    }

    // MARK: - Public API

    func connect() {
        guard webSocketTask == nil else { return }
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        receiveMessage()
        startPriceFeed()
    }

    func disconnect() {
        timer?.cancel()
        timer = nil
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
        isConnected = false
    }

    // MARK: - Private API

    private func initializePrices() {
        symbols = symbols.map { symbol in
            var updated = symbol
            let basePrice = Double.random(in: 50...500)
            updated.price = basePrice
            updated.previousPrice = basePrice
            return updated
        }
    }

    private func startPriceFeed() {
        timer = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.sendPriceUpdates()
            }
    }

    private func sendPriceUpdates() {
        for symbol in symbols {
            let changePercent = Double.random(in: -0.05...0.05)
            let newPrice = max(1, symbol.price * (1 + changePercent))
            let roundedPrice = (newPrice * 100).rounded() / 100

            let message = "\(symbol.id):\(roundedPrice)"
            pendingUpdates[symbol.id] = roundedPrice

            webSocketTask?.send(.string(message)) { [weak self] error in
                if error != nil {
                    DispatchQueue.main.async {
                        self?.isConnected = false
                    }
                }
            }
        }
    }

    private func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self.handleEchoedMessage(text)
                default:
                    break
                }
                self.receiveMessage()

            case .failure:
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
    }

    private func handleEchoedMessage(_ text: String) {
        guard let (symbolId, price) = Self.parseMessage(text) else { return }

        DispatchQueue.main.async { [weak self] in
            self?.applyPriceUpdate(symbolId: symbolId, price: price)
        }
    }

    func applyPriceUpdate(symbolId: String, price: Double) {
        if let index = symbols.firstIndex(where: { $0.id == symbolId }) {
            symbols[index].previousPrice = symbols[index].price
            symbols[index].price = price
        }
    }

    static func parseMessage(_ text: String) -> (symbolId: String, price: Double)? {
        let components = text.split(separator: ":")
        guard components.count == 2,
              let price = Double(components[1]) else { return nil }
        return (String(components[0]), price)
    }
}
