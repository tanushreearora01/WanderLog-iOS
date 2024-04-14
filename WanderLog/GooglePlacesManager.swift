//
//  GooglePlacesManager.swift
//  WanderLog
//
//  Created by Tanushree Arora on 4/12/24.
//

import Foundation
import GooglePlaces
import CoreLocation

struct Place {
    let name: String
    let identifier: String
}

final class GooglePlacesManager {
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {
        
    }
    enum PlacesError: Error {
        case failedToFind
        case failedToGetCordinates
    }
    public func setUp() {
        GMSPlacesClient.provideAPIKey("AIzaSyDlLjK0Rodaq7u6KFTxfDuhIDadddMRvu0")
    }
    
    public func findPlaces(query: String, completion: @escaping (Result <[Place], Error>) -> Void){
        
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        client.findAutocompletePredictions(fromQuery: query , filter: filter, sessionToken: nil)
        {
            results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlacesError.failedToGetCordinates))
                return
            }
            
            let places: [Place] = results.compactMap({
                Place(name: $0.attributedFullText.string,
                      identifier: $0.placeID
                )
            })
            
            completion(.success(places))
        } 
    }
    
    public func resolveLocation(
        for place: Place,
        completion:@escaping (Result<CLLocationCoordinate2D, Error>) -> Void
    ){
        client.fetchPlace(fromPlaceID: place.identifier, placeFields: .coordinate, sessionToken: nil)
        {
            googlePlace, error in
            guard let googlePlace = googlePlace, error == nil  else {
                return
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude, longitude: googlePlace.coordinate.longitude)
            completion(.success(coordinate))
        }
    }
}
