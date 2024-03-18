//
//  NavBarUI.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI

struct NavBarUI: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                   Image(systemName: "house")
                 }
            BucketListView()
                .tabItem {
                    Image(systemName: "basket")
                }
            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                }
            AIView()
                .tabItem {
                    Image(systemName: "sparkles.rectangle.stack")
                }
            ProfileMapView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    NavBarUI()
}
