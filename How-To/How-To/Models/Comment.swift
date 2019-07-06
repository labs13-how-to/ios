//
//  Comment.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 7/5/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
struct Comment: Codable {
    
    var id: Int
    var user_id: Int
    var post_id: Int
    var comment: String
    
    init(id: Int, user_id: Int, post_id: Int, comment: String) {
        self.id = id
        self.user_id = user_id
        self.post_id = post_id
        self.comment = comment
    }
    
    
}
