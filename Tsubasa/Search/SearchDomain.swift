//
//  SearchDomain.swift
//  Tsubasa
//
//  Created by Aidan Juma on 29/07/2023.
//

import ComposableArchitecture
import Foundation

struct SearchDomain: ReducerProtocol {
    struct State: Equatable {
        var selectedTicketType = TicketType.oneWay
    }

    enum TicketType {
        case oneWay
        case twoWay
    }

    enum Action: Equatable {
        case changeTicketType(TicketType)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeTicketType(let type):
                state.selectedTicketType = type
                return .none
            }
        }
    }
}
