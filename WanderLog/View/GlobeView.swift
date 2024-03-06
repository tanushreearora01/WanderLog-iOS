//
//  GlobeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit

struct Locations: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct GlobeView: View {

    @State private var locations: [Locations] =
    [Locations(name: "USA Home", coordinate: CLLocationCoordinate2D(latitude: 41.273885, longitude: -72.953464)),
     Locations(name: "India Home", coordinate: CLLocationCoordinate2D(latitude: 29.918182, longitude: 73.869415))
     ]
    
    var body: some View {
        Map(){
            ForEach(locations){ location in
                Marker(location.name,coordinate: location.coordinate)
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        
    }
}

#Preview {
    GlobeView()
}
