//
//  ListCell.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/16/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit

class ListCell: UICollectionViewCell {
    
    var postID: Int?
    
    let radius: CGFloat = 8
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8590026498, green: 0.9080110788, blue: 0.9488238692, alpha: 1)
        imageView.image = UIImage(named: "Succulents")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let textBGView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.90)
        
        // Next 3 lines allow you to choose which corners are rounded on a UIView
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Howto Title blah blah blah blah blah hahahahaha"
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "7/23/2019"
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.6323309541, green: 0.6328232288, blue: 0.632407248, alpha: 1)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "✪✪✪✪✪ 𐄁133"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(red:0.52, green:0.72, blue:0.55, alpha:1)
        return label
    }()
    
    func setupView(view: UIView){
        
        let stackView = UIStackView(arrangedSubviews: [
                                                        titleLabel,
                                                        textBGView,
            
                                                        ])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(20)
            make.right.bottom.equalTo(-20)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9807477593, green: 0.9807477593, blue: 0.9807477593, alpha: 1)
        self.backgroundView = imageView
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
    
}
