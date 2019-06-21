//
//  Tags.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
struct Tags : Codable {
    let id : Int?
    let post_id : Int?
    let tag_id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case post_id = "post_id"
        case tag_id = "tag_id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        tag_id = try values.decodeIfPresent(Int.self, forKey: .tag_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
