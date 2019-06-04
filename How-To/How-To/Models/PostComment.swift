//
//  PostComment.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct PostComment: Codable {
    
    var id: Int?
    let user_id: Int
    let post_id: Int
    var comment: String
    
    init(id: Int?, user_id: Int, post_id: Int, comment: String) {
        self.id = id
        self.user_id = user_id
        self.post_id = post_id
        self.comment = comment
    }
}
