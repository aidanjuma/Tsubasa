//
//  SearchView.swift
//  Tsubasa
//
//  Created by Aidan Juma on 25/07/2023.
//
//  Inspired by: https://cdn.dribbble.com/userupload/4152935/file/original-80a28f3c17f92ac0921e2b93a61ea89b.png

import SwiftUI

struct SearchView: View {
    var body: some View {
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
                VStack {
                    HStack {
                        Text("Hey!")
                            .font(.title)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SearchView()
}
