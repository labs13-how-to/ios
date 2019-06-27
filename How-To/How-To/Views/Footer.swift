//
//  Footer.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class Footer: UICollectionReusableView {
    
    var howto: Int?
    
    //    var footerLabel: UILabel{
    //        let label = UILabel()
    //        label.sizeToFit()
    //        label.font = .boldSystemFont(ofSize: 12)
    //        label.text = "View More"
    //
    //        return label
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.addSubview(footerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
