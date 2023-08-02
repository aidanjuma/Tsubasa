//
//  RootDomain.swift
//  Tsubasa
//
//  Created by Aidan Juma on 24/07/2023.
//

import ComposableArchitecture
import Foundation

struct RootDomain: ReducerProtocol {
    struct State: Equatable {
        var selectedTab = Tab.search
        var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
    }
    
    enum Tab {
        case search
        case logbook
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case tryFirstTimeSetup // Data obtained from UserDefaults.
        case markFirstTimeSetupAsComplete // Data obtained from UserDefaults.
    }
    
    @Dependency(\.airportDataApiClient) var airportDataApiClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .tryFirstTimeSetup:
                // TODO:
                if state.isFirstLaunch {
                    // Fetch commercial-airports.json from GitHub, then...
                    // ...map data to SQLite database (for use with search).
                }
                return .none
            case .markFirstTimeSetupAsComplete:
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                return .none
            }
        }
    }
}
