//
//  SymbolRowView.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import SwiftUI

struct SymbolRowView: View {

    // MARK: - Properties

    let symbol: StockSymbol
    @State private var flashColor: Color?

    // MARK: - View

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(symbol.id)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(symbol.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(spacing: 6) {
                Text(String(format: "$%.2f", symbol.price))
                    .font(.body)
                    .fontWeight(.semibold)
                    .monospacedDigit()

                priceChangeIndicator
            }
        }
        .padding(.vertical, 4)
        .background(flashColor?.opacity(0.15) ?? Color.clear)
        .animation(.easeOut(duration: 0.3), value: flashColor)
        .onChange(of: symbol.priceChange) {
            switch symbol.priceChange {
            case .up:
                flashColor = .green
            case .down:
                flashColor = .red
            case .unchanged:
                flashColor = nil
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                flashColor = nil
            }
        }
    }

    // MARK: - Private API

    @ViewBuilder
    private var priceChangeIndicator: some View {
        switch symbol.priceChange {
        case .up:
            Image(systemName: "arrowtriangle.up.fill")
                .foregroundStyle(.green)
                .font(.caption)
        case .down:
            Image(systemName: "arrowtriangle.down.fill")
                .foregroundStyle(.red)
                .font(.caption)
        case .unchanged:
            Image(systemName: "minus")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
    }
}
