//
//  ProfileMapView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI

struct ProfileMapView: View {
    @State private var progress = 0.7
    var body: some View {
        VStack{
            ProfileView()
            GlobeView()
            ProgressView(value: progress)
            Spacer().frame(height: 30)
        }
        
        
    }
}

#Preview {
    ProfileMapView()
}
