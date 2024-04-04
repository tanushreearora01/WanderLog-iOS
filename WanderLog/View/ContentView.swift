//
//  ContentView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            LoginView()
//            NavBarUI(tabViewSelection:2)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
