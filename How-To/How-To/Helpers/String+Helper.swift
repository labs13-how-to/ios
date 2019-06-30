//
//  String+Helper.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/30/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation


extension String {
    func truncate(characterLimit: Int) -> Substring {
        return prefix(characterLimit)
    }
    
    
    func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    func generateRandomNumberString(length: Int) -> String {
        let characters = "0123456789"
        return String((0...length-1).map{ _ in characters.randomElement()! })
        
    }
}
