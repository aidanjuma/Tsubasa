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
        WithViewStore(self.store) { viewStore in
            GeometryReader { geometry in
                Color.background
                    .ignoresSafeArea()
                // ZStack: Rounded blue background area w/ map.
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
                            Text("hey-string")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(.white)
                            // TODO: Profile photo/settings button/view...
                        }
                        Text("search-tagline-string")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.bottom, .top], 7.5)
                        // HStack: One-Way/Return Buttons
                        HStack {
                            RoundedRectangleButton(
                                store: store.scope(
                                    state: \.oneWayButtonState,
                                    action: { _ in .changeTicketType(.oneWay) }
                                ),
                                cornerRadius: 15.0,
                                width: geometry.size.width * 0.45,
                                height: 50.0,
                                label: "one-way-string",
                                scaleFactor: 0.9
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
                                label: "return-string",
                                scaleFactor: 0.9
                            )
                        }
                        // HStack: Origin/Destination selector, with switcher.
                        HStack {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(.clear)
                                        .frame(width: 30)
                                        .overlay(
                                            Circle()
                                                .stroke(.gray.opacity(0.2), lineWidth: 1)
                                        )
                                    Image(systemName: "airplane.departure")
                                        .font(.system(size: 14))
                                        .foregroundColor(.accentColor)
                                }
                                Rectangle()
                                    .fill(.gray.opacity(0.2))
                                    .frame(width: 1, height: 24)
                                ZStack {
                                    Circle()
                                        .fill(.clear)
                                        .frame(width: 30)
                                        .overlay(
                                            Circle()
                                                .stroke(.gray.opacity(0.2), lineWidth: 1)
                                        )
                                    Image(systemName: "airplane.arrival")
                                        .font(.system(size: 14))
                                        .foregroundColor(.accentColor)
                                }
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("from-string")
                                            .font(.system(size: 12))
                                            .fontWeight(.medium)
                                            .fontDesign(.rounded)
                                            .foregroundColor(.gray.opacity(0.8))
                                        Text("(IATA) | (Orig. Name)")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                    }
                                }
                                Rectangle()
                                    .fill(.gray.opacity(0.2))
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .padding(.top, -4)
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("to-string")
                                            .font(.system(size: 12.0))
                                            .fontWeight(.medium)
                                            .fontDesign(.rounded)
                                            .foregroundColor(.gray.opacity(0.8))
                                        Text("(IATA) | (Dest. Name)")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                    }
                                }
                            }
                            // TODO: Functionality.
                            // Button: Switch origin with destination.
                            Button {} label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .padding(8)
                                    .foregroundColor(.accentColor)
                                    .background {
                                        Circle()
                                            .fill(Color(hex: "#ecf0ff"))
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background {
                            RoundedRectangle(cornerRadius: 20.0)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 3)
                        }
                        // HStack: Date(s) & passenger count selector.
                        HStack {
                            // Date(s):
                            VStack(alignment: .leading) {
                                Text("Date(s)")
                                    .font(.system(size: 16.0))
                                    .fontWeight(.medium)
                                    .fontDesign(.rounded)
                                    .foregroundColor(.gray)
                                Text("(Departure/Arrival)")
                                    .font(.system(size: 18.0))
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .background {
                                Color(.card)
                                    .cornerRadius(15.0)
                            }
                            .onTapGesture {
                                viewStore.send(.toggleDateSelectionSheetVisibility)
                            }
                            .sheet(isPresented: viewStore.binding(get: { $0.showDateSelectionSheet }, send: .toggleDateSelectionSheetVisibility)) {
                                ModifiedDatePicker(store:
                                    Store(initialState: ModifiedDatePickerDomain.State(), reducer: ModifiedDatePickerDomain())
                                )
                            }
                            // Passenger(s)
                            VStack(alignment: .leading) {
                                Text("Passenger(s)")
                                    .font(.system(size: 16.0))
                                    .fontWeight(.medium)
                                    .fontDesign(.rounded)
                                    .foregroundColor(.gray)
                                HStack {
                                    Text("(#)")
                                        .font(.system(size: 18.0))
                                        .fontWeight(.semibold)
                                        .fontDesign(.rounded)
                                }
                            }
                            .padding()
                            .foregroundColor(.black)
                            .background {
                                Color(.card)
                                    .cornerRadius(15.0)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    SearchView(store: Store(initialState: SearchDomain.State()) {
        SearchDomain()
    })
}
#endif
