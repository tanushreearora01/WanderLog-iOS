//
//  PickerViewModel.swift
//  WanderLog
//
//  Created by Arora, Tanushree  on 4/6/24.
//

import Foundation

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
    
    init() {
        selectedCountry = countries.first
        selectedCity = countries.first?.cities.first
    }
}
