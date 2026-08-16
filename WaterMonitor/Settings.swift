//
//  Settings.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/16/26.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var vManager : viewModel
    @State private var selectedIP : String = ""
    @State private var selectedPort : String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 4) {
                    Text("Hub Settings")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text("Update the connection details for your water hub")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 12)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 20) {
                    fieldLabel("IP Address", icon: "network")
                    TextField("e.g. 192.168.1.42", text: $selectedIP)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.decimalPad)
                        .appTextFieldStyle()

                    fieldLabel("Port", icon: "number")
                    TextField("e.g. 8080", text: $selectedPort)
                        .keyboardType(.numberPad)
                        .appTextFieldStyle()
                }
                .glassPanel()
                .padding(.horizontal)

                Button {
                    if !selectedIP.isEmpty && !selectedPort.isEmpty {
                        if let a = Int(self.selectedPort) {
                            vManager.ipAddress = selectedIP
                            vManager.port = a
                            vManager.completedSetup = true
                            vManager.toggle = true
                            vManager.errorMessage = "Changed saved succesfully!"
                            vManager.showError.toggle()

                        } else {
                            vManager.errorMessage = "Port must be a number"
                            vManager.showError.toggle()
                        }

                    } else {
                        vManager.errorMessage = "Please provide an input to both the ip address and port"
                        vManager.showError.toggle()
                    }
                } label: {
                    Text("Save Changes")
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(selectedIP.isEmpty || selectedPort.isEmpty)
                .opacity(selectedIP.isEmpty || selectedPort.isEmpty ? 0.6 : 1)
                .padding(.horizontal)

                Spacer(minLength: 20)
            }
        }
        .appBackground()
        .alert(vManager.errorMessage, isPresented: $vManager.showError) {

        }
        .onAppear {
            self.selectedIP = vManager.ipAddress
            self.selectedPort = String(vManager.port)
        }
    }
}

#Preview {
    Settings()
        .environmentObject(viewModel())
}
