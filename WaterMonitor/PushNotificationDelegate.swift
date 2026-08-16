//
//  PushNotificationDelegate.swift
//  WaterMonitor
//
//  Created by Ashkon Adjoudani on 8/16/26.
//

import UIKit

final class PushNotificationDelegate: NSObject, UIApplicationDelegate {
    static var shared: PushNotificationDelegate!
    private var pendingContinuation: CheckedContinuation<String, Error>?

    override init() {
        super.init()
        PushNotificationDelegate.shared = self
    }

    func awaitDeviceToken(_ continuation: CheckedContinuation<String, Error>) {
        pendingContinuation = continuation
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        pendingContinuation?.resume(returning: token)
        pendingContinuation = nil
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pendingContinuation?.resume(throwing: error)
        pendingContinuation = nil
    }
}
