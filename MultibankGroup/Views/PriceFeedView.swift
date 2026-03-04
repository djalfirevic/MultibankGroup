//
//  PriceFeedView.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import SwiftUI

struct PriceFeedView: View {

    // MARK: - Properties

    @EnvironmentObject private var service: WebSocketService
    @EnvironmentObject private var router: Router<AppRoute>

    // MARK: - View

    var body: some View {
        List(service.sortedSymbols) { symbol in
            Button {
                router.push(.symbolDetail(symbolId: symbol.id))
            } label: {
                SymbolRowView(symbol: symbol)
            }
            .tint(.primary)
        }
        .listStyle(.plain)
        .navigationTitle("Price Feed")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                connectionStatusIndicator
            }
            ToolbarItem(placement: .topBarTrailing) {
                feedToggleButton
            }
        }
    }

    // MARK: - Private API

    private var connectionStatusIndicator: some View {
        Circle()
            .fill(service.isConnected ? Color.green : Color.red)
            .frame(width: 12, height: 12)
    }

    private var feedToggleButton: some View {
        Button {
            if service.isConnected {
                service.disconnect()
            } else {
                service.connect()
            }
        } label: {
            Text(service.isConnected ? "Stop" : "Start")
                .fontWeight(.medium)
        }
    }
}

#Preview {
    RootView()
}
