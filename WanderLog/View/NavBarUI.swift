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
                AIView()
                    .tabItem {
                        Image(systemName: "sparkles.rectangle.stack")
                    }.tag(3)
                ProfileMapView()
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(4)
            }
            
            
        }
        .navigationBarHidden(true)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

//#Preview {
//    NavBarUI(tabViewSelection : 0,)
//}



