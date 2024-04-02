//
//  ProfileMapView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI

struct ProfileMapView: View {
    @State private var progress = 0.7
    @State private var showPhotos = false
    var body: some View {
        VStack{
            VStack{
                ProfileView()
                Divider()
            }                
            .padding()
            GlobeView()
            ProgressView(value: progress)
                .padding()
            Spacer()
                .frame(height: 30)
        }
    }
}

#Preview {
    ProfileMapView()
}
