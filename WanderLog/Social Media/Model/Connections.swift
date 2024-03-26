//
//  Connections.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/25/24.
//

import Foundation

class Connections: Identifiable{
    var id: String
    var userID1: String
    var userID2: String
    var status: String
    
    
    init? (id: String, data: [String: Any]){
        self.id = id
        self.userID1 = data["userID1"] as! String
        self.userID2 = data["userID2"] as! String
        self.status = data["status"] as! String

    }
}
