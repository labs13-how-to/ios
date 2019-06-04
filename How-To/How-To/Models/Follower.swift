//
//  Follower.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Follower: Codable {
    var id: Int?
    let follower_id: Int
    let following_id: Int
    
    init(id: Int, follower_id: Int, following_id: Int) {
        self.id = id
        self.follower_id = follower_id
        self.following_id = following_id
    }
}
