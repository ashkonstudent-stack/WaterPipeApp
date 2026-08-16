//
//  Theme.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/16/26.
//

import SwiftUI

extension View {
    func appBackground() -> some View {
        background(
            LinearGradient(colors: [.blue,.cyan.mix(with: .white, by: 0.1)], startPoint: .bottom, endPoint: .trailing)
                .ignoresSafeArea()
        )
    }

    func glassPanel() -> some View {
        padding()
            .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
    }

    func appTextFieldStyle() -> some View {
        textFieldStyle(.plain)
            .padding()
            .background(.white.opacity(0.9), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

func fieldLabel(_ text: String, icon: String) -> some View {
    Label {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
    } icon: {
        Image(systemName: icon)
            .foregroundStyle(.white)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.semibold))
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}
