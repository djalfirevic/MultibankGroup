//
//  RootView.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import SwiftUI

struct RootView: View {

    // MARK: - Properties

    @StateObject private var service: WebSocketService
    @StateObject private var coordinator: RootCoordinator

    // MARK: - Initialization

    init() {
        let service = WebSocketService()
        _service = StateObject(wrappedValue: service)
        _coordinator = StateObject(wrappedValue: RootCoordinator(service: service))
    }

    // MARK: - View

    var body: some View {
        coordinator.start()
            .onOpenURL { url in
                coordinator.handleDeepLink(url)
            }
    }
}

#Preview {
    RootView()
}
