//
//  TagCell.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 7/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit

class TagCell: UICollectionViewCell {
    
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "category"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(view: UIView){
        
        view.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(4)
        }
        
    }
}
