//
//  UserReview.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct PostReview: Codable {
    
    var id: Int?
    let user_id: Int
    let post_id: Int
    var rating: Int
    var review: String
    
    init(id: Int?, user_id: Int, post_id: Int, rating: Int, review: String) {
        self.id = id
        self.user_id = user_id
        self.post_id = post_id
        self.rating = rating
        self.review = review
    }
}
