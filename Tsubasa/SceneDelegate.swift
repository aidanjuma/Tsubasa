//
//  SceneDelegate.swift
//  Tsubasa
//
//  Created by Aidan Juma on 02/08/2023.
//
//  Takes/manages state from within Root/RootDomain.swift

import ComposableArchitecture
import SwiftUI

@main
struct Tsubasa: App {
    let store: Store<RootDomain.State, RootDomain.Action>

    init() {
        self.store = Store(
            initialState: RootDomain.State(),
            reducer: RootDomain()
        )
    }

    var body: some Scene {
        WindowGroup {
            WithViewStore(self.store) { _ in
                RootView(store: store)
            }
        }
    }
}
