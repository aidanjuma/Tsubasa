//
//  RoundedRectangleButton.swift
//  Tsubasa
//
//  Created by Aidan Juma on 29/07/2023.
//

import ComposableArchitecture
import SwiftUI

struct RoundedRectangleButton: View {
    let store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>

    @State private var cornerRadius: CGFloat
    @State private var width: CGFloat
    @State private var height: CGFloat

    init(store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>, cornerRadius: CGFloat, width: CGFloat, height: CGFloat) {
        self.store = store
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: width, height: height)
                    .foregroundColor(viewStore.isToggleable && viewStore.isToggled != nil ? .selection : .white)
                    .onTapGesture {
                        viewStore.send(RoundedRectangleButtonDomain.Action.togglePressed)
                    }
            }
        }
    }
}
