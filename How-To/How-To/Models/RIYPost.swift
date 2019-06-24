//
//  RIYPost.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
struct RIYPost : Codable {
    let id : Int?
    let title : String?
    let img_url : String?
    let description : String?
    let difficulty : String?
    let duration : String?
    let skills : String?
    let supplies : String?
    let created_by : String?
    let created_at : String?
    let username : String?
    let tags : [Tags]?
    let review_count : Int?
    let review_avg : Int?
    let comments_count : Int?
    let favorites_count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case img_url = "img_url"
        case description = "description"
        case difficulty = "difficulty"
        case duration = "duration"
        case skills = "skills"
        case supplies = "supplies"
        case created_by = "created_by"
        case created_at = "created_at"
        case username = "username"
        case tags = "tags"
        case review_count = "review_count"
        case review_avg = "review_avg"
        case comments_count = "comments_count"
        case favorites_count = "favorites_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        img_url = try values.decodeIfPresent(String.self, forKey: .img_url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
        duration = try values.decodeIfPresent(String.self, forKey: .duration)
        skills = try values.decodeIfPresent(String.self, forKey: .skills)
        supplies = try values.decodeIfPresent(String.self, forKey: .supplies)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        review_count = try values.decodeIfPresent(Int.self, forKey: .review_count)
        review_avg = try values.decodeIfPresent(Int.self, forKey: .review_avg)
        comments_count = try values.decodeIfPresent(Int.self, forKey: .comments_count)
        favorites_count = try values.decodeIfPresent(Int.self, forKey: .favorites_count)
    }
    
}
