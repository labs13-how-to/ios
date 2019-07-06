//
//  Howto.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
struct Howto: Codable {
    
  
    
    var id: Int?
    var title: String
    var img_url: String?
    var vid_url: String?
    var description: String
    var difficulty: String
    var duration: String
    var skills: String?
    var supplies: String?
    let created_by: String?
    let created_at: String
    var username: String?
    var tags: [PostTag]?
    var steps:[PostSteps]?
    var reviews: [PostReview]?
    var review_count: Int?
    var review_avg: Double?
    var comments_count: Int?
    var favorites_count: Int?
    var comments: [Comment]?
    var favorites: [Favorite]?
    
    
    init(id: Int?, title: String, img_url: String?, vid_url: String?, description: String, difficulty: String, duration: String, skills: String?, supplies: String?, created_by: String?, created_at: String , username: String?, tags: [PostTag]?, steps: [PostSteps]?, reviews: [PostReview]?, review_count: Int?, review_avg: Double?, comments: [Comment]?, favorites: [Favorite]?, comments_count: Int?, favorites_count: Int?){
        
        self.id = id
        self.title = title
        self.img_url = img_url
        self.vid_url = vid_url
        self.description = description
        self.difficulty = difficulty
        self.duration = duration
        self.skills = skills
        self.supplies = supplies
        self.created_by = created_by
        self.created_at = created_at
        self.username = username
        self.tags = tags ?? []
        self.steps = steps ?? []
        self.reviews = reviews ?? []
        self.review_count = review_count
        self.review_avg = review_avg
        self.comments = comments ?? []
        self.favorites = favorites ?? []
        self.comments_count = comments_count
        self.favorites_count = favorites_count
        
    }
}




