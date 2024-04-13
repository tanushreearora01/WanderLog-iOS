//
//  NotificationView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/13/24.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

