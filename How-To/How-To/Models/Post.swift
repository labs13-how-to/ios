//
//  Post.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Post: Codable {
    
//    enum CodingKeys: String, CodingKey {
//        case imgURL = "img_url"
//        case creator = "created_by"
//        case timeStamp = "created_at"
//    }
    
    var id: Int?
    var title: String
    var img_url: String
    var description: String
    var difficulty: String
    var duration: String
    var skills: String?
    var supplies: String?
    let created_by: Int
    let created_at: String
    
    
    init(id: Int?, title: String, img_url: String, description: String, difficulty: String, duration: String, skills: String?, supplies: String?, created_by: Int, created_at: String ){
        
        self.id = id
        self.title = title
        self.img_url = img_url
        self.description = description
        self.difficulty = difficulty
        self.duration = duration
        self.skills = skills
        self.supplies = supplies
        self.created_by = created_by
        self.created_at = created_at
        
    }
}


