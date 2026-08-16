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
            Tab("Home",systemImage: "house") {
                MainmenuView()
                    .environmentObject(vManager)
            }
            Tab("Settings",systemImage: "gear") {
                Settings()
                    .environmentObject(vManager)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(viewModel())
}
