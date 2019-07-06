//
//  TagCell.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 7/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9807477593, green: 0.9807477593, blue: 0.9807477593, alpha: 1)
        setupView(view: self)
        
        //        //MARK: SHADOW SETUP
        //        layer.shadowColor = #colorLiteral(red: 0.5493490696, green: 0.5497819781, blue: 0.5494160652, alpha: 1)
        //        layer.shadowOffset = CGSize(width: 0.15, height: 0.15)
        //        layer.shadowRadius = 4
        //        layer.shadowOpacity = 0.1
        //        layer.masksToBounds = true
        //        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        //        layer.backgroundColor = UIColor.clear.cgColor
        //
        //        contentView.layer.masksToBounds = false
        //        layer.cornerRadius = radius
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(view: UIView){
        
        let stackView = UIStackView()
        
        view.addSubview(stackView)
        
        stackView.fillSuperview()
        
    }
    
}

