//
//  SearchView.swift
//  Tsubasa
//
//  Created by Aidan Juma on 25/07/2023.
//
//  Inspired by: https://cdn.dribbble.com/userupload/4152935/file/original-80a28f3c17f92ac0921e2b93a61ea89b.png

import ComposableArchitecture
import SwiftUI

struct SearchView: View {
    let store: Store<SearchDomain.State, SearchDomain.Action>

    var body: some View {
        WithViewStore(self.store) { _ in
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    Color.accentColor
                        .frame(height: geometry.size.height * 0.5)
                        .cornerRadius(60.0, corners: [.bottomLeft, .bottomRight])
                        .ignoresSafeArea()
                    Image("BlueDotmap")
                        .resizable()
                        .scaledToFit()
                        .offset(y: geometry.size.height * -0.05)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Hey!")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(.white)
                        }
                        Text("Find a ✈️ that works with your 🗓️.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.bottom, .top], 7.5)
                        HStack {
                            RoundedRectangleButton(
                                store: store.scope(
                                    state: \.oneWayButtonState,
                                    action: { _ in .changeTicketType(.oneWay) }
                                ),
                                cornerRadius: 15.0,
                                width: geometry.size.width * 0.45,
                                height: 50.0,
                                label: "One Way"
                            )
                            Spacer()
                            RoundedRectangleButton(
                                store: store.scope(
                                    state: \.twoWayButtonState,
                                    action: { _ in .changeTicketType(.twoWay) }
                                ),
                                cornerRadius: 15.0,
                                width: geometry.size.width * 0.45,
                                height: 50.0,
                                label: "Return"
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SearchView(store: Store(initialState: SearchDomain.State()) {
        SearchDomain()
    })
}
