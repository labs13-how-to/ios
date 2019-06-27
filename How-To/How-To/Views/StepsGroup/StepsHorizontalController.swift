//
//  StepsHorizontalController.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/26/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class StepsHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "StepsCell"
    
    var howto: Howto? {
        didSet{
            stepsCount = (howto?.steps!.count)!
            collectionView.reloadData()
        }
    }
    
    var stepsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: cellID)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stepsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 25, height: view.frame.height - 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StepCell
        guard let steps = howto?.steps! else { fatalError() }
        cell.step = steps[indexPath.item]
        
        
        return cell
    }
    
}
