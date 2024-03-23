//
//  ContentView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/21/24.
//

import SwiftUI
class AppVariables: ObservableObject {
    @Published var selectedTab: Int = 0
    
}

struct ContentView: View {
    var body: some View {
        VStack{
           NavBarUI()
        }
        .preferredColorScheme(.light)
    }
    
}

#Preview {
    ContentView()
}
