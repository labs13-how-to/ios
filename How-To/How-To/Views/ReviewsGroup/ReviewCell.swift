//
//  ReviewCell.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/27/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit

class ReviewCell: UICollectionViewCell {
    
    var howto: Howto? {
        didSet{
            setupView()
        }
    }
    
    var review: PostReview? {
        didSet{
            setupView()
            setNeedsDisplay()
        }
    }
    var rating = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // MAKE A CALL FOR ALL USERS TO FILTER THE CORRECT NAME a
        
        backgroundColor = .white
        
    }
    
    
    func setupView(){
        backgroundColor = .white
        guard let unwrappedReview = review else { fatalError() }
        
        let nameLabel = UILabel()
        nameLabel.text = howto?.username
        nameLabel.font = UIFont(name: "nunito-regular", size: 24)
        //        let starStack = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        
        ////
        
        let starStack = UIStackView()
        //        starStack.distribution = .equalCentering
        starStack.spacing = 0
        let roundedRating = Int(review!.rating)
        print(roundedRating)
        
        let starSize = 40
        
        if roundedRating != 0 {
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
        
        
        
        ////
        let textView = UITextView()
        textView.text = unwrappedReview.review
        
        let cellStack = UIStackView(arrangedSubviews: [nameLabel, starStack, textView])
        cellStack.axis = .vertical        
        textView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        textView.isEditable = false
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.font = UIFont(name: "amiri-regular", size: 19)
        
        
        addSubview(cellStack)
        cellStack.fillSuperview()
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        
        let starInset = Int(frame.width) - (starSize*5)
        
        starStack.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(cellStack.frame.width/2)
            make.right.equalTo(-starInset)
        }
        
        
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(450)
            make.bottom.equalTo(-8)
            //            make.left.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
