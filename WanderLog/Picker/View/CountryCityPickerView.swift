//
//  CountryCityPickerView.swift
//  WanderLog
//
//  Created by Arora, Tanushree  on 4/6/24.
//

import SwiftUI

struct CountryCityPickerView: View {
    @StateObject var viewModel = PickerViewModel()
    
    var body: some View {
        Form {
            Picker("Select Country", selection: $viewModel.selectedCountry) {
                ForEach(viewModel.countries, id: \.self) { country in
                    Text(country.name).tag(country as Country?)
                }
            }
            .pickerStyle(.menu) 
        
            if let cities = viewModel.selectedCountry?.cities {
                Picker("Select City", selection: $viewModel.selectedCity) {
                    ForEach(cities, id: \.self) { city in
                        Text(city.name).tag(city as City?)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .onChange(of: viewModel.selectedCountry) { newCountry in
            // Reseting the selected city when changing countries
            viewModel.selectedCity = newCountry?.cities.first
        }
    }
}

#Preview {
    CountryCityPickerView()
}
