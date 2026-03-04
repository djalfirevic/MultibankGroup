//
//  Router.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Combine
import SwiftUI

final class Router<T: Hashable & Identifiable>: ObservableObject {

    // MARK: - Properties

    @Published var root: T
    @Published var fullScreenCover: T?
    @Published var sheet: T?
    @Published var path: NavigationPath

    // MARK: - Initialization

    init(root: T) {
        self.root = root
        path = NavigationPath()
    }

    // MARK: - Public API

    func updateRoot(root: T) {
        self.root = root
    }

    func push(_ path: T) {
        self.path.append(path)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func present(_ path: T, fullScreen: Bool = true) {
        if fullScreen {
            fullScreenCover = path
        } else {
            sheet = path
        }
    }

    func dismiss() {
        fullScreenCover = nil
        sheet = nil
    }
}
