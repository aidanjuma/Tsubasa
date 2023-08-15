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
        var launchProcessesState = LaunchProcessesDomain.State()
    }

    enum Tab {
        case search
        case logbook
    }

    enum Action: Equatable {
        case tabSelected(Tab)
        case airportList(LaunchProcessesDomain.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.launchProcessesState, action: /RootDomain.Action.airportList) { LaunchProcessesDomain() }
        Reduce { state, action in
            switch action {
            case .airportList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}
