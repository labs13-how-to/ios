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
    let user_id: Int?
    let auth_id: String?
    let post_id: Int
    var rating: Double
    var review: String
    
    init(id: Int?, user_id: Int?, auth_id: String?, post_id: Int, rating: Double, review: String) {
        self.id = id
        self.user_id = user_id
        self.auth_id = auth_id
        self.post_id = post_id
        self.rating = rating
        self.review = review
    }
}
