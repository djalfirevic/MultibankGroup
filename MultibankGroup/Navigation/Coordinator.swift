//
//  Coordinator.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Combine
import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype RoutePath: Hashable & Identifiable
    associatedtype RouteView: View

    var router: Router<RoutePath> { get set }

    @ViewBuilder
    func viewForRoute(_ route: RoutePath) -> RouteView
}

extension Coordinator {
    func start() -> some View {
        RouterView(router: router, contentView: viewForRoute)
    }
}
