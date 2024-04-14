//
//  Notifications.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/13/24.
//

// Inspired from https://github.com/SwiftfulThinking/SwiftUI-Continued-Learning/blob/main/SwiftfulThinkingContinuedLearning/LocalNotificationBootcamp.swift modified as per usage in our app
import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func scheduleNotification() {
        print("scheduled!")
        
        let content = UNMutableNotificationContent()
        content.title = "Happy Travelling!"
        content.subtitle = "It's time to capture your moments..."
        content.sound = .default
        content.badge = 1 // NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
                

        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 0
        // everyday at 4:00 PM Local time.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
//        let coordinates = CLLocationCoordinate2D(
//            latitude: 40.00,
//            longitude: 50.00)
//        let region = CLCircularRegion(
//            center: coordinates,
//            radius: 100,
//            identifier: UUID().uuidString)
//        region.notifyOnEntry = true
//        region.notifyOnExit = true
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)

    }
    
}
