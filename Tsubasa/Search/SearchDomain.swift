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
        // Ticket Type:
        var selectedTicketType = TicketType.oneWay
        var oneWayButtonState = RoundedRectangleButtonDomain.State(isToggleable: true, isToggled: true)
        var twoWayButtonState = RoundedRectangleButtonDomain.State(isToggleable: true, isToggled: false)
        // Date(s):
        var showDateSelectionSheet = false
        // Passenger(s):
        var showPassengerSelectionSheet = false
    }

    enum TicketType {
        case oneWay
        case twoWay
    }

    enum Action: Equatable {
        case changeTicketType(TicketType)
        case toggleDateSelectionSheetVisibility
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeTicketType(let type):
                state.selectedTicketType = type
                switch type {
                case .oneWay:
                    state.oneWayButtonState.isToggled = true
                    state.twoWayButtonState.isToggled = false
                case .twoWay:
                    state.oneWayButtonState.isToggled = false
                    state.twoWayButtonState.isToggled = true
                }
                return .none
            case .toggleDateSelectionSheetVisibility:
                state.showDateSelectionSheet.toggle()
                return .none
            }
        }
    }
}
