//
//  WanderLogApp.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/21/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import UserNotifications

public var currentUserId:String = ""
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
          if granted {
              DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
              }
          } else {
              print("Permission for push notifications denied.")
          }
      }
    return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token: \(token)")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the notification and perform necessary actions
        completionHandler()
    }
}
@main
struct WanderLogApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        UINavigationBar.applyCustomAppearance()
    }
    var body: some Scene {
       
        WindowGroup {
            ContentView()
        }
    }
}
//Got the below code from Apple Tutorials:  https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview
fileprivate extension UINavigationBar {
    
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
