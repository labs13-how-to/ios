//
//  HowtoDetailCollectionViewCell.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class HowtoDetailCollectionViewCell: UICollectionViewCell {
    
    var howto: Howto?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
        self.backgroundColor = #colorLiteral(red: 0.08956647664, green: 0.2180776596, blue: 0.4915035367, alpha: 1)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
