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
            reducer: RootDomain(fetchAirports: RootDomain.live.fetchAirports)
        )
    }

    var body: some Scene {
        WindowGroup {
            WithViewStore(self.store) { viewStore in
                RootView(store: store)
                    .onAppear {
                        // Run the airport list updater on launch (i.e. appearance of RootView)
                        viewStore.send(.airportList(.fetchAirports))
                    }
                    .onChange(of: viewStore.launchProcessesState, perform: { state in
                        if !(state.airportList.isEmpty), state.dataLoadingStatus == .success {
                            viewStore.send(.airportList(.completeFirstLaunch))
                        }
                    })
            }
        }
    }
}
