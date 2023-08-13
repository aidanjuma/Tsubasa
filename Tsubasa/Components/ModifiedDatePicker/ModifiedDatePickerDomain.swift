//
//  ModifiedDatePickerDomain.swift
//  Tsubasa
//
//  Created by Aidan Juma on 13/08/2023.
//

import ComposableArchitecture
import Foundation

struct ModifiedDatePickerDomain: ReducerProtocol {
    struct State: Equatable {
        var selectedTab = Tab.outbound
        var outboundDate = Date()
        var inboundDate = Date()
    }

    enum Tab {
        case outbound
        case inbound
    }

    enum Action: Equatable {
        case tabSelected(Tab)
        case changeSelectedOutboundDate(Date)
        case changeSelectedInboundDate(Date)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .changeSelectedOutboundDate(let date):
                state.outboundDate = date
                if date > state.inboundDate { state.inboundDate = date }
                return .none
            case .changeSelectedInboundDate(let date):
                state.inboundDate = date
                return .none
            }
        }
    }
}
