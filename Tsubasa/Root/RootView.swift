//
//  RootView.swift
//  Tsubasa
//
//  Created by Aidan Juma on 24/07/2023.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: Store<RootDomain.State, RootDomain.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            TabView(selection: viewStore.binding(get: \.selectedTab, send: RootDomain.Action.tabSelected)
            ) {
                SearchView(store: Store(initialState: SearchDomain.State(), reducer: SearchDomain())).tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                LogbookView().tabItem {
                    Image(systemName: "book.pages")
                    Text("Logbook")
                }
            }
        }
    }
}

#Preview {
    RootView(store: Store(initialState: RootDomain.State()) {
        RootDomain()
    })
}
