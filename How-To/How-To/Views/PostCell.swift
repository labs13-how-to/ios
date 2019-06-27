//
//  PostCell.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/4/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit


class PostCell: UICollectionViewCell {
    
    weak var parentCollectionVC : HomeSearchCollectionViewController?
    
    var reviews: [PostReview]?
    var howto: Howto? {
        
        didSet{
            setupView()
        }
        
    }
    var postID: Int?
    var rating: Double?
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
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Next 3 lines allow you to choose which corners are rounded on a UIView
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
//        label.font = .boldSystemFont(ofSize: 17)
        label.font = UIFont(name: "nunito-regular", size: 17)
        label.text = "Howto Title blah blah blah blah blah hahahahaha"
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "nunito-regular", size: 12)
        label.textColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "7/23/2019"
//        label.font = .systemFont(ofSize: 12)
        label.font = UIFont(name: "nunito-regular", size: 12)
        label.textColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
////        backgroundColor = #colorLiteral(red: 0.5765730143, green: 0.8659184575, blue: 0.9998990893, alpha: 1)
//        backgroundView = imageView
//        let blurEffect = UIBlurEffect(style: .extraLight)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = CGRect(x: 0, y: imageView.bounds.maxY/2+30, width: imageView.bounds.width, height: imageView.bounds.height/2 - 29)
//
//
//        backgroundView?.addSubview(blurredEffectView)
//
//        let starStack = UIStackView()
//        starStack.alignment = .leading
//        starStack.distribution = .equalCentering
//        var starRating : [UIImageView] = []
//        let roundedRating = Int(rating!)
//        print(roundedRating)
//
//        if rating != 0 {
//            for _ in 0...roundedRating {
//                let fullStar = UIImageView()
//                fullStar.image = #imageLiteral(resourceName: "ic_star_24px")
//                fullStar.tintColor = #colorLiteral(red: 0.9843137264, green: 0.7084275484, blue: 0.160784319, alpha: 1)
//    //            starRating.append(fullStar)
//                starStack.addArrangedSubview(fullStar)
//            }
//            if roundedRating < 5 {
//                for _ in starStack.subviews.count...4 {
//                    let emptyStar = UIImageView()
//                    emptyStar.image = #imageLiteral(resourceName: "Solid Star")
//                    emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
//                    starStack.addArrangedSubview(emptyStar)
//                }
//            }
//        } else {
//            for _ in 0...4 {
//                let emptyStar = UIImageView()
//                emptyStar.image = #imageLiteral(resourceName: "ic_star_24px")
//                emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
//                emptyStar.snp.makeConstraints { (make) in
//                    make.width.equalTo(16)
//                    make.height.equalTo(16)
//                }
//                starStack.addArrangedSubview(emptyStar)
//            }
//        }
//        let starContainer = UIStackView(arrangedSubviews: [starStack, UIStackView()])
//        starContainer.distribution = .equalSpacing
//        backgroundView!.layer.cornerRadius = radius
//        let infoStackView = UIStackView(arrangedSubviews: [ dateLabel, starContainer ])
//        infoStackView.axis = .vertical
//        infoStackView.contentMode = .bottom
//        infoStackView.spacing = 8
//        infoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.frame.width/2)
//        let stackView = UIStackView(arrangedSubviews: [
//            titleLabel, infoStackView
//            ])
//        stackView.spacing = 8
//        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
//        addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 4, right: 6)
//        pinBackground(textBGView, to: stackView)
//
//        stackView.layer.cornerRadius = radius
//        stackView.layer.masksToBounds = true
//        stackView.clipsToBounds = true
//
//        //MARK: SHADOW SETUP
//        layer.shadowColor = #colorLiteral(red: 0.3498458862, green: 0.3163031638, blue: 0.3288204372, alpha: 1)
//        layer.shadowOffset = CGSize(width: 0.25, height: 0.25)
//        layer.shadowRadius = 4
//        layer.shadowOpacity = 0.5
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
//        layer.backgroundColor = UIColor.clear.cgColor
//
//        contentView.layer.masksToBounds = true
//        layer.cornerRadius = radius
//
//
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellTapped(){
        
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView){
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    func setupView(){
        //        backgroundColor = #colorLiteral(red: 0.5765730143, green: 0.8659184575, blue: 0.9998990893, alpha: 1)
        backgroundView = imageView
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: imageView.bounds.maxY/2+30, width: imageView.bounds.width, height: imageView.bounds.height/2 - 29)
        
        
        backgroundView?.addSubview(blurredEffectView)
        
        let starStack = UIStackView()
        starStack.alignment = .center
//        starStack.distribution = .equalCentering
        starStack.spacing = 0
        var starRating : [UIImageView] = []
        let roundedRating = Int(rating!)
        print(roundedRating)
        
        let starSize = 20
        
        if rating != 0 {
            for _ in 0...(roundedRating-1) {
                let fullStar = UIImageView()
                fullStar.image = #imageLiteral(resourceName: "ic_star_24px")
                fullStar.tintColor = #colorLiteral(red: 0.9843137264, green: 0.7084275484, blue: 0.160784319, alpha: 1)
                fullStar.snp.makeConstraints { (make) in
                    make.width.equalTo(starSize)
                    make.height.equalTo(starSize)
                }
                //            starRating.append(fullStar)
                starStack.addArrangedSubview(fullStar)
            }
            if starStack.subviews.count < 5 {
                for _ in starStack.subviews.count...4 {
                    let emptyStar = UIImageView()
                    emptyStar.image = #imageLiteral(resourceName: "ic_star_24px")
                    emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
                    emptyStar.snp.makeConstraints { (make) in
                        make.width.equalTo(starSize)
                        make.height.equalTo(starSize)
                    }
                    starStack.addArrangedSubview(emptyStar)
                }
            }
        } else {
            for _ in 0...4 {
                let emptyStar = UIImageView()
                emptyStar.image = #imageLiteral(resourceName: "ic_star_24px")
                emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
                emptyStar.snp.makeConstraints { (make) in
                    make.width.equalTo(starSize)
                    make.height.equalTo(starSize)
                }
                starStack.addArrangedSubview(emptyStar)
            }
        }
        var unwrappedReviewCount = 0
        if howto?.review_count != nil {
            unwrappedReviewCount = howto!.review_count!
        }
        ratingLabel.text = ("∙" + String(unwrappedReviewCount))
        ratingLabel.font = UIFont(name: "nunito-regular", size: 14)
        ratingLabel.textColor = #colorLiteral(red: 0.5455184579, green: 0.5459486246, blue: 0.5455850959, alpha: 1)
        starStack.addArrangedSubview(ratingLabel)
        
        authorLabel.text = howto?.username
        
        
        let starContainer = UIStackView(arrangedSubviews: [starStack, UIStackView()])
        starContainer.spacing = 0
        backgroundView!.layer.cornerRadius = radius
        let infoStackView = UIStackView(arrangedSubviews: [ starContainer, authorLabel, dateLabel ])
        
        starContainer.snp.makeConstraints { (make) in
            make.left.equalTo(2)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(4)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(4)
            make.bottom.equalTo(-6)
            
        }
        
        infoStackView.axis = .vertical
        infoStackView.contentMode = .bottom
        infoStackView.spacing = 4
        infoStackView.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: self.frame.width/2)
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, infoStackView
            ])
        
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 2, left: 5, bottom: 4, right: 5)
        pinBackground(textBGView, to: stackView)
        
        stackView.layer.cornerRadius = radius
        stackView.layer.masksToBounds = true
        stackView.clipsToBounds = true
        
        //MARK: SHADOW SETUP
        layer.shadowColor = #colorLiteral(red: 0.3498458862, green: 0.3163031638, blue: 0.3288204372, alpha: 1)
        layer.shadowOffset = CGSize(width: 0.25, height: 0.25)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        contentView.layer.masksToBounds = true
        layer.cornerRadius = radius
        
    }
    
}


