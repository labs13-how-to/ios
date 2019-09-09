//
//  RatingBar.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 7/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class RatingBar: UIView {
    
        init(frame: CGRect, percentage: CGFloat) {
        super.init(frame: frame)
        
        self.layer.backgroundColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
            let percentRect = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width * percentage, height: self.frame.height))
            percentRect.backgroundColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
            
            addSubview(percentRect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
