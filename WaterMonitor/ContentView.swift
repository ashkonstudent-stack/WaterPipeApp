//
//  ContentView.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/14/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vManager : viewModel
    var body: some View {
        TabView {
            Tab("Home",systemImage: "house.fill") {
                MainmenuView()
                    .environmentObject(vManager)
            }
            Tab("Settings",systemImage: "gearshape.fill") {
                Settings()
                    .environmentObject(vManager)
            }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
        .environmentObject(viewModel())
}
