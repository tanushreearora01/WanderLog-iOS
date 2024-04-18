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
import FirebaseFirestore

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func scheduleNotification() {
        print("scheduled!")
        
        let content = UNMutableNotificationContent()
        content.title = "Happy Travelling!"
        content.subtitle = "It's time to capture your moments..."
        content.sound = .default
        content.badge = 1 // NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
                
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
    
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)

    }
    func scheduleNotificationLocation(latitude: Double, longitude: Double) {
        print("scheduled!")
        
        let content = UNMutableNotificationContent()
        content.title = "Happy Travelling!"
        content.subtitle = "It's time to capture your moments..."
        content.sound = .default
        content.badge = 1 // NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
                
        let coordinates = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        print("schedule for (\(latitude),\(longitude)")
    }
    
    
}
