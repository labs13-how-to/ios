//
//  User.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/2/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    
    var id: Int
    var username: String
    var password: String
    var role: String
    var timestamp: Date
    
    init(id: Int, username: String, password: String, role: String, timestamp: Date){
        self.id = id
        self.username = username
        self.password = password
        self.role = role
        self.timestamp = timestamp
    }
    
}
