//
//  UserManager.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/24/24.
//

// UserManager.swift

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {} // Private initializer to ensure singleton usage

    var currentUser: User?

    struct User {
        var id: String
        var username: String
        var email: String
        var bio: String
        var fullname: String
    }

    func updateUser(id: String, username: String, email: String,  bio: String, fullname:String) {
        currentUser = User(id: id,username: username, email: email,  bio: bio, fullname: fullname)
    }
}

