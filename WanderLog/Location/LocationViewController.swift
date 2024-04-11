//
//  LocationViewController.swift
//  WanderLog
//
//  Created by Tanushree Arora on 4/10/24.
//
// got bits of the code from https://stackoverflow.com/questions/26434250/cllocationmanagerdelegate-methods-not-being-called-in-swift-code

import UIKit
import CoreLocation
import CoreLocationUI
import MapKit


class LocationViewController: UIViewController, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    // over riding the Did Load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //asking for user's permisssion for location sercvices
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
   
    // getting the cordinates of the location
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
    
    // throwing error if location fails
    func locationManager (_ manager: CLLocationManager, didFailWithError: Error) {
        print("Failed to find user's location")
    }
    
    // checking user's location
    func locationManager(_ manager: CLLocationManager){
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied :
            print("Location access was restricted or denied")
        case .authorizedAlways, .authorizedWhenInUse :
            if CLLocationManager.locationServicesEnabled() {
                locationManager.stopUpdatingLocation()
            }
            
        @unknown default:
            fatalError("Encoutered Unauthorization status")
        }
    }
}
