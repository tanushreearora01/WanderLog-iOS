//
//  PickerViewModel.swift
//  WanderLog
//
//  Created by Arora, Tanushree  on 4/6/24.
//

import Foundation
import CoreLocation

// for country data
struct Country: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    var cities: [City]
}

// for city data
struct City: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
}

class PickerViewModel: ObservableObject {
    // sample data 
    let countries: [Country] = [
        Country(name: "USA", cities: [
            City(name: "New York"),
            City(name: "Los Angeles"),
            City(name: "Chicago")
        ]),
        Country(name: "Canada", cities: [
            City(name: "Toronto"),
            City(name: "Vancouver"),
            City(name: "Montreal")
        ]),
        Country(name: "United Kingdom", cities: [
            City(name: "London"),
            City(name: "Manchester"),
            City(name: "Birmingham")
        ])
    ]
    
    @Published var selectedCountry: Country?
    @Published var selectedCity: City?
    @Published var coordinates: CLLocationCoordinate2D?
    
    private var geocoder = CLGeocoder()
    
    init() {
        selectedCountry = countries.first
        selectedCity = countries.first?.cities.first
    }
    
    func geocodeSelectedCity() {
            guard let country = selectedCountry?.name,
                  let city = selectedCity?.name else {
                print("City or country not selected")
                return
            }

            let addressString = "\(city), \(country)"
            geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
                guard let strongSelf = self else { return }

                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first, let location = placemark.location {
                    strongSelf.coordinates = location.coordinate
                    print("Geocoded coordinates: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                } else {
                    print("No coordinates found for this location")
                }
            }
        }
}
