//
//  ContentView.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/14/26.
//

import SwiftUI

struct MainmenuView: View {
    @EnvironmentObject var vManager : viewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 4) {
                        Text("Control Center")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.largeTitle)
                        Text("Monitor and manage your water hub")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)

                    connectionStatusCard

                    VStack(spacing: 16) {
                        Button {
                            //TODO: Code send a push notification request to the viewModel
                        } label: {
                            actionRow(icon: "bell.badge.fill", title: "Enable Notifications", subtitle: "Get alerted about water events")
                        }
                        .buttonStyle(.plain)

                        Button {
                            //TODO: Code a tcp connection request to the main hub
                            Task {
                                let result = try await vManager.attemptHandshake(token: "abc123")
                                if result != "ok" {
                                    print("Error while sending handshake: \(result)")
                                } else {
                                    print("Handshake completed successfully!")
                                }
                            }

                        } label: {
                            actionRow(icon: "antenna.radiowaves.left.and.right", title: "Handshake Request", subtitle: "Connect to your hub")
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 20)
                }
            }
            .appBackground()
            .toolbar(.hidden)
        }
    }

    private var connectionStatusCard: some View {
        HStack(spacing: 16) {
            Image(systemName: "network")
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(.white.opacity(0.2), in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("Hub Status Connection")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.75))
                Text(vManager.completedHandshake == false ? "Not connected" : "\(vManager.ipAddress):\(vManager.port)")
                    .font(.headline)
                    .foregroundStyle(.white)
            }

            Spacer()

            Circle()
                .fill(vManager.completedHandshake == false ? Color.orange : Color.green)
                .frame(width: 10, height: 10)
        }
        .glassPanel()
        .padding(.horizontal)
    }

    private func actionRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.6))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.black.opacity(0.3))
        }
        .padding()
        .background(.white.opacity(0.92), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

#Preview {
    ContentView()
        .environmentObject(viewModel())
}
