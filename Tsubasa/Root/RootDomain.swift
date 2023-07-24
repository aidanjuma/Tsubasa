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
    }

    enum Tab {
        case search
        case logbook
    }

    enum Action: Equatable {
        case tabSelected(Tab)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }
}
