//
//  AppRoute.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Foundation

enum AppRoute: Hashable, Identifiable {
    case feed
    case symbolDetail(symbolId: String)

    // MARK: - Identifiable

    var id: String {
        switch self {
        case .feed: "feed"
        case .symbolDetail(let symbolId): "symbolDetail-\(symbolId)"
        }
    }
}
