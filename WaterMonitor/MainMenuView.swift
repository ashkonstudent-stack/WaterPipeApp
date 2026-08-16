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
            ZStack {
                LinearGradient(colors: [.blue,.cyan.mix(with: .white, by: 0.1)], startPoint: .bottom, endPoint: .trailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Control Center")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.largeTitle)
                        .frame(maxWidth:.infinity)
                    Spacer()
                    Button {
                        //TODO: Code send a push notification request to the viewModel
                    } label: {
                        Text("Enable Notifications")
                            .frame(maxWidth:.infinity,maxHeight:50)
                            .padding()
                            .foregroundStyle(.black)
                            .background(.white)
                            .font(.title)
                            .cornerRadius(16)
                            .padding()

                        
                        
                    }
                    Button {
                        //TODO: Code a tcp connection request to the main hub
                    } label: {
                        Text("Handshake request")
                            .frame(maxWidth:.infinity,maxHeight:50)
                            .padding()
                            .foregroundStyle(.black)
                            .background(.white)
                            .font(.title)
                            .cornerRadius(16)
                            .padding()

                        
                        
                    }
                    Spacer()

                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(viewModel())
}
