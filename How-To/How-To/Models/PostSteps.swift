//
//  PostSteps.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

struct PostSteps: Codable {
    
    var id: Int?
    var post_id: Int
    var step_num: Int
    var title : String
    var instruction: String
    var img_url: String?
    var vid_url: String?
    
    init(id: Int?, post_id: Int, step_num: Int, title: String, instruction: String, img_url: String?, vid_url: String?) {
        self.id = id
        self.post_id = post_id
        self.step_num = step_num
        self.title = title
        self.instruction = instruction
        self.img_url = img_url
        self.vid_url = vid_url
    }
    
}
