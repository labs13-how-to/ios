//
//  ReviewFooter.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 7/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
class ReviewFooter: UICollectionReusableView {
    
    var howto: Howto?
    var reviews: [PostReview]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.addSubview(footerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
