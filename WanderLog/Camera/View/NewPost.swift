//
//  NewPost.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/27/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

struct NewPost: View {
    @State private var caption = ""
    @State private var city = ""
    @State private var country = ""
    @State var image: Image
    @State private var photoUploaded = false
    @StateObject var viewModel = PickerViewModel()
    @StateObject var locationViewModel = LocationViewController()
    
    var body: some View {
        VStack{
            image
                .resizable()
                .frame(height: 300)
                .scaledToFit()
            TextField("Write a caption", text: $caption, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5, reservesSpace: true)
            
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
            .onChange(of: viewModel.selectedCountry) {
                newCountry in
                // Reseting the selected city when changing countries
                viewModel.selectedCity = newCountry?.cities.first
            }
            
            Spacer()
            NavigationLink(destination: NavBarUI(tabViewSelection: 0), isActive: $photoUploaded){}
            Button( action:{
                uploadPhoto()
                photoUploaded = true
            } ,label:{
                Text("Share")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(.borderedProminent)
            .padding()
            
        }
        .padding()
        .onTapGesture {
            // Dismiss the keyboard when tapping outside of text fields
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .task{
            locationViewModel.viewDidLoad()
            let _ = await locationViewModel.checkLocationAuthorization()
        }
        
    }
    func uploadPhoto(){
        if  ((viewModel.selectedCountry?.name) != nil), ((viewModel.selectedCity?.name) != nil) {
            print("city,country added")
            city = viewModel.selectedCity?.name ?? ""
            country = viewModel.selectedCountry?.name ?? ""
        }
            else {
                print(locationViewModel.userLocation?.coordinate.latitude ?? 0.0,locationViewModel.userLocation?.coordinate.longitude ?? 0.0)
                reverseGeocodeCoordinates()
            
        }
        if let currentUser = UserManager.shared.currentUser
        {
            print("Showing profile for \(currentUser.username)")
            let FirestoreRef = Storage.storage().reference()
            //convert image to data
            let uiImage: UIImage = self.image.asUIImage()
            let imageData = uiImage.jpegData(compressionQuality: 0.8)
            
            //check if image data is valid
            guard imageData != nil else{
                return
            }
            let path = "posts/\(currentUser.id)/\(UUID().uuidString).jpg"
            //specify file path and name
            let FileRef = FirestoreRef.child(path)
            
            //upload photo
            _ = FileRef.putData(imageData!, metadata: nil) { metadata, err in
                if err == nil{
                    let db = Firestore.firestore()
                    db.collection("posts").document().setData([
                        "userID" : currentUser.id,
                        "imageUrl" : path,
                        "content" : caption,
                        "location" : [city,country],
                        "likes" : [],
                        "comments" : [],
                    ])
                }
            }
        } else {
            print("No user is currently logged in.")
        }
    }
    func reverseGeocodeCoordinates() {
        var geocoder = CLGeocoder()
        let location = locationViewModel.userLocation
        geocoder.reverseGeocodeLocation(location!) { placemarks, error in

                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first {
                    // create a readable address from the lattitudes and longitudes
                    let address = [ placemark.locality, placemark.country]
                        .compactMap { $0 }
                        .joined(separator: ", ")
                    city = placemark.locality ?? ""
                    country = placemark.country ?? ""
                    print("Reverse geocoded address: \(address)")
                } else {
                    print("No address found for these coordinates")
                }
            }
        }
    
    
}



#Preview {
    NewPost(image: Image("1"))
}
