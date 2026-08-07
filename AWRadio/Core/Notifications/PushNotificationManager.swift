//
//  PushNotificationManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import UserNotifications
import Combine

@MainActor
final class PushNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = PushNotificationManager()
    
    @Published var isAuthorized: Bool = false
    @Published var notifications: [AppNotification] = AppNotification.mockList
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            self.isAuthorized = granted
            return granted
        } catch {
            print("Push notification authorization error: \(error)")
            return false
        }
    }
    
    func scheduleShowReminder(program: Program) {
        let content = UNMutableNotificationContent()
        content.title = "Show Starting Soon: \(program.title)"
        content.body = "Tune into AW Radio to listen live with \(program.presenterName)."
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: program.startTime.addingTimeInterval(-300))
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: program.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        HapticsManager.shared.notification(type: .success)
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    nonisolated func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
