//
//  RouterView.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import SwiftUI

struct RouterView<T: Hashable & Identifiable, Content: View>: View {

    // MARK: - Properties

    @ObservedObject var router: Router<T>
    @ViewBuilder var contentView: (T) -> Content

    // MARK: - View

    var body: some View {
        NavigationStack(path: $router.path) {
            contentView(router.root)
                .navigationDestination(for: T.self) { path in
                    contentView(path)
                }
                .fullScreenCover(item: $router.fullScreenCover) { path in
                    contentView(path)
                }
                .sheet(item: $router.sheet) {} content: { path in
                    contentView(path)
                }
        }
        .environmentObject(router)
    }
}
