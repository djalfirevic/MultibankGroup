//
//  RootCoordinator.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Combine
import SwiftUI

final class RootCoordinator: Coordinator {

    // MARK: - Properties

    @Published var router: Router<AppRoute>
    let service: WebSocketService

    // MARK: - Initialization

    init(service: WebSocketService) {
        self.service = service
        router = Router(root: .feed)
    }

    // MARK: - Coordinator

    @ViewBuilder
    func viewForRoute(_ route: AppRoute) -> some View {
        switch route {
        case .feed:
            PriceFeedView()
                .environmentObject(service)
        case .symbolDetail(let symbolId):
            SymbolDetailView(symbolId: symbolId)
                .environmentObject(service)
        }
    }

    // MARK: - Public API

    func handleDeepLink(_ url: URL) {
        guard url.scheme == "stocks",
              url.host == "symbol",
              let symbolId = url.pathComponents.last,
              symbolId != "/" else { return }

        router.push(.symbolDetail(symbolId: symbolId.uppercased()))
    }
}
