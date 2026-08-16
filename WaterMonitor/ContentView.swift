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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(viewModel())
}
