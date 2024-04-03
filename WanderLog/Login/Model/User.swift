//
//  User.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/24/24.
//

import Foundation
// Data Model for users collection
class User:Identifiable{
    var id: String
    var fullname: String
    var email: String
    var password: Int
    var username: String
    var bio: String
    
    init? (id: String, data: [String: Any]){
        self.id = id
        self.fullname = data["fullname"] as! String
        self.email = data["email"] as! String
        self.password = data["password"] as! Int
        self.username = data["username"] as! String
        self.bio = data["bio"] as! String
    }
}

