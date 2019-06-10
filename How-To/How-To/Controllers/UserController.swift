//
//  UserController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class UserController: Codable {
    
//    static let shared = UserController()
    var currentUser: User?
    
    func createUser(id: Int, username: String, password: String, auth_id: String?, role: String, created_at: Date) {
        let user = User(id: id, username: username, password: password, role: role, timestamp: created_at)
        currentUser = user
    }
    
    func logOut() {
        currentUser = nil
    }
    
    
//    private(set) var currentUser: User?
}
