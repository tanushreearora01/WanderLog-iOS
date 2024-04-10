//
//  GlobeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit
import FirebaseFirestore


struct GlobeView: View {
    let db = Firestore.firestore()
    //Create a MapCameraPosition variable to set the globe center and lens distance
    @State private var mapCamPos: MapCameraPosition = .camera(MapCamera(
        centerCoordinate: CLLocationCoordinate2D(latitude: 39, longitude: 34),
        distance: 29000000))
    @State var user : User
    //Location array to store markers from the locations collection in the db
    @State var locations = [Locations]()
    @State var progress = 0.0
    var body: some View {
        VStack{
            Map(position: $mapCamPos){
                ForEach(locations){ location in
                    if location.visited{
                        Marker(location.city,coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                            .tint(.green)
                    }
                    else{
                        Marker(location.city,coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                            .tint(.red)
                    }
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            
            ProgressView(value: progress)
                .padding()
        }
        .onAppear(){
            getLocations()
        }
    }
    func getProgress(){
        var visitedCount = 0
        for location in locations{
            if location.visited {
                visitedCount += 1
            }
        }
        if locations.count != 0{
            progress = Double(visitedCount)/Double(locations.count)
        }
    }
    func getLocations(){
        locations = []
        db.collection("locations").whereField("userID", isEqualTo: user.id).getDocuments(){(querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get locations from db
                for document in querySnapshot!.documents{
                    if let location = Locations(id:document.documentID, data: document.data()){
                        locations.append(location)
                    }
                }
            }
            getProgress()
        }
        
        
    }
}


