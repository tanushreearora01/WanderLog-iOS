//
//  Location.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/25/24.
//

import Foundation

//Data Model for locations collection
struct Locations: Identifiable {
    var id: String
    var userId: String
    var city: String
    var country: String
    var latitude: Double
    var longitude: Double
    
    init? (id: String, data: [String: Any]){
        self.id = id
        self.userId = data["userID"] as! String
        self.city = data["city"] as! String
        self.country = data["country"] as! String
        self.latitude = data["latitude"] as! Double
        self.longitude = data["longitude"] as! Double
    }
}



