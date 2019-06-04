//
//  Favorite.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    
    var id: Int?
    let user_id: Int
    let post_id: Int
    
    init(id: Int?, user_id: Int, post_id: Int) {
        self.id = id
        self.user_id = user_id
        self.post_id = post_id
    }
}
