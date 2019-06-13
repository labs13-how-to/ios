//
//  User.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/2/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let user: [User]
}

struct User: Codable {
    let id: Int
    var username: String
    var password: String?
    var auth_id : String?
//    var password: String
    let role: String
    let created_at: String
    
    init(id: Int, auth_id: String, username: String, role: String = "user", created_at: String){
        self.id = id
        self.username = username
        self.auth_id = auth_id
//        self.password = password
        self.role = role
        self.created_at = created_at
    }
    
}
