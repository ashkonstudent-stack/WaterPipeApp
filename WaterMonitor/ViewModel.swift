//
//  ViewModel.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/14/26.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import UserNotifications

enum PushNotificationError: Error {
    case notAuthorized
}

final class viewModel : ObservableObject {
    @AppStorage("IPAddress") var ipAddress : String = ""
    @AppStorage("Port") var port : Int = 0
    @AppStorage("Handshake") var completedHandshake : Bool = false
    @AppStorage("Setup") var completedSetup : Bool = false
    @Published var toggle: Bool = false
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    @Published var connected : Bool = false

    func requestPushNotificationToken() async throws -> String {
        let granted = try await UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound])
        guard granted else {
            throw PushNotificationError.notAuthorized
        }
        return try await withCheckedThrowingContinuation { continuation in
            PushNotificationDelegate.shared.awaitDeviceToken(continuation)
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
