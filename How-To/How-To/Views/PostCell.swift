//
//  PostCell.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/4/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
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
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        
        // Next 3 lines allow you to choose which corners are rounded on a UIView
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "7/23/2019"
        label.textColor = #colorLiteral(red: 0.6323309541, green: 0.6328232288, blue: 0.632407248, alpha: 1)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "✪✪✪✪✪ 𐄁133"
        label.textColor = #colorLiteral(red: 0.6323309541, green: 0.6328232288, blue: 0.632407248, alpha: 1)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = #colorLiteral(red: 0.5765730143, green: 0.8659184575, blue: 0.9998990893, alpha: 1)
        backgroundView = imageView
        backgroundView!.layer.cornerRadius = radius
        let infoStackView = UIStackView(arrangedSubviews: [ dateLabel, ratingLabel ])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, infoStackView
            ])
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 35).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //#colorLiteral(red: 0.5493490696, green: 0.5497819781, blue: 0.5494160652, alpha: 1)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 6, bottom: 6, right: 6)
        pinBackground(textBGView, to: stackView)
        
        stackView.layer.cornerRadius = radius
        stackView.layer.masksToBounds = true
        stackView.clipsToBounds = true
        
        //MARK: SHADOW SETUP
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1.0)
        layer.shadowRadius = radius
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        contentView.layer.masksToBounds = true
        layer.cornerRadius = radius
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView){
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    
    
    
}

public extension UIView {
    func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

//extension UIView {
//
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//
//}