//
//  WanderLogApp.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/21/24.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
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
