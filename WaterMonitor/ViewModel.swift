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

struct jsonStatus : Codable {
    let status : String
    let token : String
}

final class viewModel : ObservableObject {
    @AppStorage("IPAddress") var ipAddress : String = ""
    @AppStorage("Port") var port : Int = 0
    @AppStorage("Handshake") var completedHandshake : Bool = false
    @AppStorage("Setup") var completedSetup : Bool = false
    @Published var toggle: Bool = false
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""

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
    func attemptHandshake(token:String) async throws -> String {
        guard let URL = URL(string:"http://\(self.ipAddress):\(self.port)/register/\(token)") else {
            return "Failed to recognize URL"
        }
        do {
            let (data,response) = try await URLSession.shared.data(from: URL)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Server error response")
                return "Server error response"
            }
            let decoded = try JSONDecoder().decode(jsonStatus.self, from: data)
            if decoded.status == "ok" {
                self.completedHandshake = true
            }
            return decoded.status
        } catch {
            print("Network or decoding error \(error.localizedDescription)")
        }
        
        return "Error"
    }
    
}
