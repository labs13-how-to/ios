//
//  HowtoDetailCollectionViewCell.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class HowtoDetailCollectionViewCell: UICollectionViewCell {
    
    var howto: Howto? {
        didSet {
            setupView()
        }
    }
//    var reviews: [PostReview]? {
//        didSet{
//            setupView()
//        }
//    }
//    var steps: [PostSteps]? {
//        didSet{
//            setupView()
//        }
//    }
    
    let horizontalController = StepsHorizontalController(collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.08956647664, green: 0.2180776596, blue: 0.4915035367, alpha: 1)
        
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupView(){
        horizontalController.howto = self.howto
    }
    
}
