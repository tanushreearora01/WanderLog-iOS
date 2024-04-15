//
//  NewBucketItemView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/10/24.
//

import SwiftUI
import CoreLocation
import FirebaseFirestore

struct NewBucketItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = PickerViewModel()
    @State var city = ""
    @State var country = ""
    @State var coordinates = CLLocationCoordinate2D()
    var body: some View {
        NavigationStack {
            Form {
                Picker("Country", selection: $viewModel.selectedCountry) {
                    ForEach(viewModel.countries, id: \.self) { country in
                        Text(country.name).tag(country as Country?)
                    }
                }
                .pickerStyle(.menu)
            
                if let cities = viewModel.selectedCountry?.cities {
                    Picker("City", selection: $viewModel.selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city.name).tag(city as City?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                HStack{
                    Button("Add") {
                        geocodeSelectedCity()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Button("Cancel") {
                        cancel()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.secondary)
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                }
            }
            .onChange(of: viewModel.selectedCountry) {
                newCountry in
                // Reseting the selected city when changing countries
                viewModel.selectedCity = newCountry?.cities.first
            }
        }
        .navigationBarTitle("New Bucket List Item", displayMode: .inline)
        Spacer()
    }
    func cancel(){
        presentationMode.wrappedValue.dismiss()
    }
    func addToBucketList(){
        let db = Firestore.firestore()
        print("Geocoded coordinates: \(Double(coordinates.latitude)), \(Double(coordinates.longitude))")
        if let currentUser = UserManager.shared.currentUser{
            let data = ["userID":currentUser.id,
                        "city":viewModel.selectedCity?.name,
                        "country":viewModel.selectedCountry?.name,
                        "latitude":Double(coordinates.latitude),
                        "longitude":Double(coordinates.longitude),
                        "visited": false] as [String:Any]
            var ref: DocumentReference? = nil
            ref = db.collection("locations").addDocument(data: data){ err in
                    if let err = err{
                        print("Error in adding doc \(err)")
                    }
                    else{
                        print("Document added with ID : \(ref!.documentID)")
                    }
                }
        }
    }
    func geocodeSelectedCity() {
        let geocoder = CLGeocoder()
        guard let country = viewModel.selectedCountry?.name,
              let city = viewModel.selectedCity?.name else {
                print("City or country not selected")
                return
                
            }

            let addressString = "\(city), \(country)"
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
//                guard let strongSelf = self else { return }

                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first, let location = placemark.location {
                    coordinates = location.coordinate
                    print(type(of: location.coordinate))
                    addToBucketList()
                    
                } else {
                    print("No coordinates found for this location")
                }
            }
        }
}

#Preview {
    NewBucketItemView()
}
