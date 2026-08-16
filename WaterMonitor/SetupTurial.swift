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
            LinearGradient(colors: [.blue,.cyan.mix(with: .white, by: 0.1)], startPoint: .bottom, endPoint: .trailing)
                .ignoresSafeArea()
            VStack {
                Text("Water Prototype Setup")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth:.infinity)
                Spacer()
                Form {
                    TextField("Enter hub ip address",text:$ipAdress)
                    TextField("Enter the port of the hub",text:$port)
                }
                .scrollContentBackground(.hidden)
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
                        .foregroundStyle(.white)
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(.green)
                        .cornerRadius(15)
                    
                        
                }

                
            }
        }
        
    }
}

#Preview {
    SetupTurial()
        .environmentObject(viewModel())
}
