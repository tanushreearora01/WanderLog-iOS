//
//  ContentView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoginView()
              .tabItem {
                 Text("Login")
               }
            ProfileView()
                .tabItem { Text("Profile") }
         }
    }
}

#Preview {
    ContentView()
}
