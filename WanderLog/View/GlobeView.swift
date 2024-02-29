//
//  GlobeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit

struct GlobeView: View {
    let dist : CLLocationDistance = 200
    let pitch : CGFloat = 400
    let heading = 90.0
    let west_haven = CLLocationCoordinate2D(latitude: 41.273885, longitude: -72.953464)
    let home = CLLocationCoordinate2D(latitude: 29.918182, longitude: 73.869415)
    var body: some View {
        Map(){
            Marker("US Home", coordinate: west_haven)
                .tint(.blue)
            Marker("India Home", coordinate: home)
                .tint(.pink)
            UserAnnotation()
        }
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GlobeView()
}
