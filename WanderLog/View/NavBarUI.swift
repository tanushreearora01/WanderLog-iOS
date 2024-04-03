//
//  NavBarUI.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI

struct NavBarUI: View {
    @State public var tabViewSelection : Int
//    @State public var currentUser : User
    var body: some View {
        NavigationStack{
            TabView(selection: $tabViewSelection){
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                BucketListView()
                    .tabItem {
                        Image(systemName: "basket")
                    }.tag(1)
                CameraView()
                    .tabItem {
                        Image(systemName: "camera")
                    }.tag(2)
                    .toolbar(.hidden, for: .tabBar)
                ProfileMapView()
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(3)
            }
            
            
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavBarUI(tabViewSelection : 3)
}



