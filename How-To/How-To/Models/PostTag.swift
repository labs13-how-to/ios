//
//  PostTag.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct PostTag: Codable {
    
    var id: Int?
    let post_id: Int
    let tag_id: Int
    var name: String?
    
    
    
    init(id: Int?, post_id: Int, tag_id: Int, name: String?) {
        self.id = id
        self.post_id = post_id
        self.tag_id = tag_id
        self.name = name
    }
}
