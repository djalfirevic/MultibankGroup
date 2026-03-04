//
//  SymbolDetailView.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import SwiftUI

struct SymbolDetailView: View {

    // MARK: - Properties

    let symbolId: String
    @EnvironmentObject private var service: WebSocketService

    private var symbol: StockSymbol? {
        service.symbols.first { $0.id == symbolId }
    }

    // MARK: - View

    var body: some View {
        if let symbol {
            ScrollView {
                VStack(spacing: 24) {
                    priceSection(symbol)
                    descriptionSection(symbol)
                }
                .padding()
            }
            .navigationTitle(symbol.id)
        } else {
            ContentUnavailableView("Symbol Not Found", systemImage: "exclamationmark.triangle")
        }
    }

    // MARK: - Private API

    private func priceSection(_ symbol: StockSymbol) -> some View {
        VStack(spacing: 12) {
            Text(symbol.name)
                .font(.title2)
                .fontWeight(.semibold)

            HStack(spacing: 8) {
                Text(String(format: "$%.2f", symbol.price))
                    .font(.system(size: 48, weight: .bold))
                    .monospacedDigit()

                priceChangeIndicator(symbol)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func priceChangeIndicator(_ symbol: StockSymbol) -> some View {
        switch symbol.priceChange {
        case .up:
            Image(systemName: "arrowtriangle.up.fill")
                .foregroundStyle(.green)
                .font(.title2)
        case .down:
            Image(systemName: "arrowtriangle.down.fill")
                .foregroundStyle(.red)
                .font(.title2)
        case .unchanged:
            Image(systemName: "minus")
                .foregroundStyle(.secondary)
                .font(.title2)
        }
    }

    private func descriptionSection(_ symbol: StockSymbol) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.headline)
            Text(symbol.description)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        SymbolDetailView(symbolId: "AAPL")
            .environmentObject(WebSocketService())
    }
}
