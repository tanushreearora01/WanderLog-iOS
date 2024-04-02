//
//  ImageData.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/1/24.
//


import Foundation
import SwiftUI
// Data Storage Model for Images Data
class ImageData:Identifiable{
    var id: String
    var caption: String
    var image: UIImage
    var username: String
    
    init? (id: String, d: [String: Any]){
        self.id = id
        self.caption = d["caption"] as! String
        self.image = d["image"] as! UIImage
        self.username = d["username"] as! String
    }
}


