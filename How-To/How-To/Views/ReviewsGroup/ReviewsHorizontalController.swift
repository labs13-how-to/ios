//
//  ReviewsHorizontalController.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/27/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class ReviewsHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "ReviewCell"
    
    var reviews: [PostReview] = []{
        didSet{
            reviewsCount = reviews.count
            collectionView.reloadData()
        }
    }
    var howto: Howto? {
        didSet{
            reviewsCount = (howto?.reviews?.count)!
            collectionView.reloadData()
        }
    }
    
    var reviewsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
        return reviewsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 500, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // DYNAMIC SIZING
//        if howto != nil {
//            if howto?.reviews != nil {
//                 let review = howto?.reviews![indexPath.item]
//                // get an estimation of height based on review
//                review?.review
//
//                let approximateHeight = 1000
//                let size = CGSize(width: Int(collectionView.frame.width), height: approximateHeight)
//                let attributes = [NSAttributedString.Key.font: UIFont(name: "nunito-regular", size: 18)]
//                let estimatedFrame = NSString(string: review!.review).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
//
//                return CGSize(width: view.frame.width, height: estimatedFrame.height)
//            }
//        }
//
        if reviewsCount == 0 {
            return CGSize(width: 0, height: 0)
        }
        
        
        return CGSize(width: view.frame.width - 25, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ReviewCell
        let reviews = self.reviews 
        cell.review = reviews[indexPath.item]
        cell.howto = self.howto
        return cell
    }
}
