//
//  userlocation.swift
//  WanderLog
//
//  Created by Arora, Tanushree  on 4/5/24.
//

import Foundation
import CoreLocation
import CoreLocationUI

final class userlocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40,
                                                                              longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    func requestAllowOnceLocationPermission() {
        
        let locationManager = CLLocationManager ()
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            // show an error
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

