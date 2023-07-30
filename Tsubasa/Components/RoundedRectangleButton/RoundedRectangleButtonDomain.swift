//
//  RoundedRectangleButtonDomain.swift
//  Tsubasa
//
//  Created by Aidan Juma on 29/07/2023.
//

import ComposableArchitecture
import Foundation

struct RoundedRectangleButtonDomain: ReducerProtocol {
    struct State: Equatable {
        var isToggleable: Bool
        var isToggled: Bool?
    }

    enum Action: Equatable {
        case togglePressed
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .togglePressed:
                if state.isToggleable {
                    state.isToggled?.toggle()
                }
                return .none
            }
        }
    }
}
