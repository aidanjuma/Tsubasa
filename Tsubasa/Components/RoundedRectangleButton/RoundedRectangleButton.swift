//
//  RoundedRectangleButton.swift
//  Tsubasa
//
//  Created by Aidan Juma on 29/07/2023.
//

import ComposableArchitecture
import SwiftUI

// TODO: Pressing animation; appear to sink into the page, and maybe add haptic feedback to this?
struct RoundedRectangleButton: View {
    let store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>

    @State private var cornerRadius: CGFloat
    @State private var width: CGFloat
    @State private var height: CGFloat
    @State private var label: LocalizedStringKey

    init(store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>, cornerRadius: CGFloat, width: CGFloat, height: CGFloat, label: LocalizedStringKey) {
        self.store = store
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
        self.label = label
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: width, height: height)
                    .foregroundColor(viewStore.isToggled == true ? .selection : .white)
                    .onTapGesture {
                        viewStore.send(.togglePressed)
                    }
                Text(label)
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(viewStore.isToggled == true ? .white : .black)
            }
        }
    }
}
