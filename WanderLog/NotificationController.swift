//
//  NotificationController.swift
//  WanderLog
//
//  Created by Tanushree Arora on 4/9/24.
//

import Foundation
import UIKit
import UserNotifications


class NotificationController: UIViewController {
    
    
    func checkForPermission () {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) {
                    didAllow, error in 
                    if didAllow {
                            self.dispatchNotification()
                        }
                }
            case .denied:
                return
            case .authorized:
                self.dispatchNotification()
            default:
                return
            }
        }
    }
    
    func dispatchNotification () {
        
    }
}
