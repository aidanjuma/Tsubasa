//
//  RoundedRectangleButton.swift
//  Tsubasa
//
//  Created by Aidan Juma on 29/07/2023.
//

import ComposableArchitecture
import CoreHaptics
import SwiftUI

struct RoundedRectangleButton: View {
    let store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>

    let cornerRadius: CGFloat
    let width: CGFloat
    let height: CGFloat
    let label: LocalizedStringKey
    let scaleFactor: CGFloat

    @GestureState var departScale: Bool = false
    @GestureState var travelScale: Bool = false
    @State private var engine: CHHapticEngine?

    init(store: Store<RoundedRectangleButtonDomain.State, RoundedRectangleButtonDomain.Action>, cornerRadius: CGFloat, width: CGFloat, height: CGFloat, label: LocalizedStringKey, scaleFactor: CGFloat) {
        self.store = store
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
        self.label = label
        self.scaleFactor = scaleFactor

        prepareHaptics()
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
            .scaleEffect(departScale ? scaleFactor : 1.0)
            .gesture(DragGesture(minimumDistance: 0)
                .updating($departScale) { _, isTapped, _ in
                    isTapped = true
                    self.attemptHapticFeedback()
                })
            .animation(.spring(response: 0.3), value: departScale)
        }
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptics engine object: \(error.localizedDescription)")
        }
    }

    func attemptHapticFeedback() {
        // Ensure that the user's device supports haptic feedback.
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // Single, intense, sharp feedback/tap.
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // Convert events into a vibration pattern, and execute immediately.
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play vibration pattern: \(error.localizedDescription).")
        }
    }
}
