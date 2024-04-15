//
//  Post.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/27/24.
//

import Foundation
// Data Model for users collection
class Posts:Identifiable{
    var id: String
    var content: String
    var imageUrl: String
    var userID: String
    var likes : [String] = []
    var comments : [[String:String]] = []
    var location : [String] = []
    
    init? (id: String, data: [String: Any]){
        self.id = id
        self.content = data["content"] as! String
        self.imageUrl = data["imageUrl"] as! String
        self.userID = data["userID"] as! String
        self.likes = data["likes"] as! [String]
        self.comments = data["comments"] as! [[String:String]]
        self.location = data["location"] as! [String]
    }
}

