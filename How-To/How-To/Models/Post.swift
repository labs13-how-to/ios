//
//  Post.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct Post: Codable, Equatable {
    var id: Int
    var title: String
    var img_url: String
    var description: String
    var difficulty: String
    var duration: String
    var skills: String
    var supplies: String
    let created_by: Int
    let created_at: Date
}
