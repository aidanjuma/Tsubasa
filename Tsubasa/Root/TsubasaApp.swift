//
//  TsubasaApp.swift
//  Tsubasa
//
//  Created by Aidan Juma on 24/07/2023.
//

import ComposableArchitecture
import SwiftUI

@main
struct TsubasaApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootDomain.State()) {
                RootDomain()
            })
        }
    }
}
