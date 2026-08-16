//
//  SetupTurial.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/16/26.
//

import SwiftUI

struct SetupTurial: View {
    @State private var ipAdress : String = ""
    @State private var port : String = ""
    @EnvironmentObject var vManager : viewModel
    var body: some View {
        ZStack {
            WaterBackground()
            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 12) {
                    Image(systemName: "drop.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.white)
                    Text("Water Prototype Setup")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    Text("Enter your hub's IP address and port to get started")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)

                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    FieldLabel(text: "Hub IP Address", icon: "network")
                    TextField("e.g. 192.168.1.42", text: $ipAdress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.decimalPad)
                        .appTextFieldStyle()

                    FieldLabel(text: "Port", icon: "number")
                    TextField("e.g. 8080", text: $port)
                        .keyboardType(.numberPad)
                        .appTextFieldStyle()
                }
                .glassPanel()
                .padding(.horizontal)

                Button {
                    if !ipAdress.isEmpty && !port.isEmpty {
                        if let a = Int(port) {
                            vManager.ipAddress = ipAdress
                            vManager.port = a
                            vManager.completedSetup = true
                            vManager.toggle = true

                        } else {
                            vManager.errorMessage = "Port must be a number"
                            vManager.showError.toggle()
                        }

                    } else {
                        vManager.errorMessage = "Please provide an input to both the ip address and port"
                        vManager.showError.toggle()
                    }
                } label: {
                    Text("Done")
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(ipAdress.isEmpty || port.isEmpty)
                .opacity(ipAdress.isEmpty || port.isEmpty ? 0.6 : 1)
                .padding(.horizontal)

                Spacer()
            }
        }
        .alert(vManager.errorMessage, isPresented: $vManager.showError) {

        }

    }
}

#Preview {
    SetupTurial()
        .environmentObject(viewModel())
}
