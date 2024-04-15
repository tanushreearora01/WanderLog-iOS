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
        Country(name: "Select Country", cities: []),
        Country(name: "USA", cities: [
            City(name: "New York"),
            City(name: "Los Angeles"),
            City(name: "Chicago"),
            City(name: "Houston"),
            City(name: "Phoenix"),
            City(name: "Philadelphia")
        ]),
        Country(name: "Canada", cities: [
            City(name: "Toronto"),
            City(name: "Vancouver"),
            City(name: "Montreal"),
            City(name: "Calgary"),
            City(name: "Ottawa"),
            City(name: "Edmonton")
        ]),
        Country(name: "United Kingdom", cities: [
            City(name: "London"),
            City(name: "Manchester"),
            City(name: "Birmingham"),
            City(name: "Glasgow"),
            City(name: "Liverpool"),
            City(name: "Edinburgh")
        ]),
        Country(name: "Australia", cities: [
            City(name: "Sydney"),
            City(name: "Melbourne"),
            City(name: "Brisbane"),
            City(name: "Perth"),
            City(name: "Adelaide"),
            City(name: "Canberra")
        ]),
        Country(name: "Germany", cities: [
            City(name: "Berlin"),
            City(name: "Hamburg"),
            City(name: "Munich"),
            City(name: "Cologne"),
            City(name: "Frankfurt"),
            City(name: "Stuttgart")
        ]),
        Country(name: "Japan", cities: [
            City(name: "Tokyo"),
            City(name: "Osaka"),
            City(name: "Kyoto"),
            City(name: "Hokkaido"),
            City(name: "Nagoya"),
            City(name: "Fukuoka")
        ]),
        Country(name: "India", cities: [
            City(name: "Mumbai"),
            City(name: "Delhi"),
            City(name: "Bangalore"),
            City(name: "Hyderabad"),
            City(name: "Chennai"),
            City(name: "Kolkata")
        ]),
        Country(name: "Brazil", cities: [
            City(name: "São Paulo"),
            City(name: "Rio de Janeiro"),
            City(name: "Belo Horizonte"),
            City(name: "Brasília"),
            City(name: "Salvador"),
            City(name: "Fortaleza")
        ]),
        Country(name: "Italy", cities: [
            City(name: "Rome"),
            City(name: "Milan"),
            City(name: "Naples"),
            City(name: "Turin"),
            City(name: "Palermo"),
            City(name: "Genoa")
        ]),
        Country(name: "China", cities: [
            City(name: "Beijing"),
            City(name: "Shanghai"),
            City(name: "Guangzhou"),
            City(name: "Shenzhen"),
            City(name: "Chengdu"),
            City(name: "Xi'an")
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
//                guard let strongSelf = self else { return }

                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first, let location = placemark.location {
//                    self!.coordinates.wrappedValue = location.coordinate
                    print(type(of: location.coordinate))
//                    print("Geocoded coordinates: \(Double(location.coordinate.latitude)), \(Double(location.coordinate.longitude))")
                } else {
                    print("No coordinates found for this location")
                }
            }
        }
    
    func reverseGeocodeCoordinates() {
            guard let coordinates = coordinates else {
                print("No coordinates available to reverse geocode")
                return
            }

            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let strongSelf = self else { return }

                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first {
                    // create a readable address from the lattitudes and longitudes
                    let address = [placemark.thoroughfare, placemark.subThoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country]
                        .compactMap { $0 }
                        .joined(separator: ", ")
                    print("Reverse geocoded address: \(address)")
                } else {
                    print("No address found for these coordinates")
                }
            }
        }
}
