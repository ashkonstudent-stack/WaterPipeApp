//
//  WaterMonitorApp.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/14/26.
//

import SwiftUI

@main
struct WaterMonitorApp: App {
    @StateObject var vManager : viewModel = viewModel()
    var body: some Scene {
        WindowGroup {
            if vManager.completedSetup == true || vManager.toggle == true{
                ContentView()
                    .environmentObject(vManager)
            } else {
                SetupTurial()
                    .environmentObject(vManager)
            }

        }
    }
}
