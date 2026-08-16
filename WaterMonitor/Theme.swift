//
//  Theme.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/16/26.
//

import SwiftUI

struct WaterBackground: View {
    var body: some View {
        LinearGradient(colors: [.blue,.cyan.mix(with: .white, by: 0.1)], startPoint: .bottom, endPoint: .trailing)
            .ignoresSafeArea()
    }
}

private struct GlassPanel: ViewModifier {
    var cornerRadius: CGFloat = 20
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
    }
}

extension View {
    func glassPanel(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassPanel(cornerRadius: cornerRadius))
    }

    func appTextFieldStyle() -> some View {
        self
            .textFieldStyle(.plain)
            .padding()
            .background(.white.opacity(0.9), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct FieldLabel: View {
    let text: String
    let icon: String
    var body: some View {
        Label {
            Text(text)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.white)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var tint: Color = .white
    var foreground: Color = .blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.semibold))
            .foregroundStyle(foreground)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(tint, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct ActionCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white.opacity(configuration.isPressed ? 0.75 : 0.92), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
