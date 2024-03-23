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
            NavBarUI(tabViewSelection:0)
        }
        .preferredColorScheme(.light)
    }
    
}

#Preview {
    ContentView()
}
