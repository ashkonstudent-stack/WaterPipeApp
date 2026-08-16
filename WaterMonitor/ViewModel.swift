//
//  ViewModel.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/14/26.
//

import Foundation
import Combine
import SwiftUI

final class viewModel : ObservableObject {
    @AppStorage("IPAddress") var ipAddress : String = ""
    @AppStorage("Port") var port : Int = 0
    @AppStorage("Handshake") var completedHandshake : Bool = false
    @AppStorage("Setup") var completedSetup : Bool = false
    @Published var toggle: Bool = false
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var connected : Bool = false
}
