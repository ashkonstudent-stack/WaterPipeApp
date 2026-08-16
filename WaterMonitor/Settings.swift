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
        ZStack {
            LinearGradient(colors: [.blue,.cyan.mix(with: .white, by: 0.1)], startPoint: .bottom, endPoint: .trailing)
                .ignoresSafeArea()
            VStack {
                
                Form {
                    if !vManager.ipAddress.isEmpty {
                        TextField(vManager.ipAddress,text: $selectedIP)
                    } else {
                        TextField("Enter ip address",text:$selectedIP)
                    }
                    if vManager.port == 0 {
                        TextField("Enter port number",text:$selectedPort)
                    } else {
                        TextField(String(selectedPort),text: $selectedPort)
                    }
                    Button {
                        if !selectedIP.isEmpty && !selectedPort.isEmpty {
                            if let a = Int(selectedIP) {
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
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth:.infinity)
                            .background(.green)
                            .cornerRadius(16)
                    }
                    
                }
                .scrollContentBackground(.hidden)


            }
            .alert(vManager.errorMessage, isPresented: $vManager.showError) {
                
            }
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
