//
//  GlobeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit

// This code snippet for globe view in mapkit is taken form https://gist.github.com/jordansinger/4113143465810848ba6fc8079cc33831

struct Location {
    var title: String
    var latitude: Double
    var longitude: Double
}
struct GlobeView: View {
    @State var locations = [
        Location(title: "US Home", latitude: 41.273885, longitude: -72.953464),
        Location(title: "India Home", latitude: 29.918182, longitude: 73.869415)
    ]
    
    var body: some View {
        MapView(locations: locations)
    }
}


struct MapView: UIViewRepresentable {
    @State var locations: [Location]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        // change the map type here
        mapView.mapType = .hybridFlyover
        
        // The map camera code comes from https://stackoverflow.com/questions/53567744/mkmapview-mapkit-trying-to-zoom-out-to-see-the-entire-globe which helped to control zoom settings of the globe.
        let mapCamera = MKMapCamera()
            
            mapCamera.pitch = 45
            mapCamera.altitude = 15000000 // example altitude
            mapCamera.heading = 45
            
            // set the camera property
            mapView.camera = mapCamera
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        for location in locations {
            // make a pins
            let pin = MKPointAnnotation()
            
            // set the coordinates
            pin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            // set the title
            pin.title = location.title
            
            // add to map
            view.addAnnotation(pin)
        }
    }
}
#Preview {
    GlobeView()
}
