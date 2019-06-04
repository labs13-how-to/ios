//
//  Tag.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct tag: Codable {
    var id: Int?
    var name: String
    
    init(id: Int?, name: String) {
        self.id = id
        self.name = name
    }
}
