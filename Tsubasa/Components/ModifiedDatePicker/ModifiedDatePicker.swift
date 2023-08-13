//
//  ModifiedDatePicker.swift
//  Tsubasa
//
//  Created by Aidan Juma on 13/08/2023.
//

import ComposableArchitecture
import SwiftUI

// TODO: Validation - notify user whenever an invalid input is made, like inboundDate < outboundDate.
struct ModifiedDatePicker: View {
    let store: Store<ModifiedDatePickerDomain.State, ModifiedDatePickerDomain.Action>

    private var oneYearFromNow: Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: .now) ?? Date()
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack(spacing: 24) {
                    Button(action: { viewStore.send(.tabSelected(.outbound)) }) {
                        Text("Outbound")
                            .font(.system(size: 20.0))
                            .fontWeight(.medium)
                    }
                    Button(action: { viewStore.send(.tabSelected(.inbound)) }) {
                        Text("Inbound")
                            .font(.system(size: 20.0))
                            .fontWeight(.medium)
                    }
                }
                .padding(.top)
                // TODO: Clean-up!
                DatePicker("", selection: viewStore.binding(get: { $0.selectedTab == .outbound ? $0.outboundDate : $0.inboundDate }, send: { viewStore.state.selectedTab == .outbound ? .changeSelectedOutboundDate($0) : .changeSelectedInboundDate($0) }), in: (viewStore.selectedTab == .inbound ? viewStore.outboundDate : .now) ... oneYearFromNow, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .presentationDetents([.medium])
            }
            .padding()
        }
    }
}
