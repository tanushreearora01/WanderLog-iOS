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
        ProfileView()
        GlobeView()
        ProgressView(value: progress)
    }
}

#Preview {
    ProfileMapView()
}
