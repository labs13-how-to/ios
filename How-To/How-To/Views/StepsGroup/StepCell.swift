//
//  StepCell.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/27/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import SDWebImage
import SnapKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}


class StepCell: UICollectionViewCell {
    
    var stepCellHeight = 500
    
    var step: PostSteps? {
        didSet{
            setupView()
            setNeedsDisplay()
        }
    }
    
    var headerLabel = UILabel(text: "Header", font: UIFont(name: "nunito-regular", size: 22)!)
    var textView = UITextView()
    var imageView = UIImageView(cornerRadius: 10)
    var videoView: WKYTPlayerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
       
//        UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        
    }
    
    func setupView(){
        
        guard let unwrappedStep = step else { fatalError() }
        
        
        headerLabel.text = ("Step " + "\(unwrappedStep.step_num) -" + " " + "\(unwrappedStep.title)")
        textView.text = step?.instruction
        
        if step?.img_url != nil {
            let imgURL = URL(string: step!.img_url!)
            imageView.load(url: imgURL!)
            let stackView = UIStackView(arrangedSubviews: [headerLabel, textView, imageView])
            stackView.axis = .vertical
            stackView.alignment = .fill
            addSubview(stackView)
            stackView.fillSuperview()
            stackView.spacing = 8
        } else {
            let stackView = UIStackView(arrangedSubviews: [headerLabel,textView])
            stackView.axis = .vertical
            stackView.alignment = .fill
            addSubview(stackView)
            stackView.fillSuperview()
        }
        
        
        headerLabel.backgroundColor = .white
        headerLabel.font = UIFont(name: "nunito-regular", size: 24)
        headerLabel.numberOfLines = 0
        headerLabel.textColor = #colorLiteral(red: 0.9993600249, green: 0.5205107927, blue: 0.1008351222, alpha: 1)
        headerLabel.snp.makeConstraints { (make) in
            make.height.equalTo(stepCellHeight/8)
        }
        
        if self.frame.width <= 375 {
            headerLabel.font = UIFont(name: "nunito-regular", size: 18)
        }
        
//
//        textView.contentInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        
        imageView.backgroundColor = .white

        if step?.img_url != nil {
            imageView.snp.makeConstraints { (make) in
                //            make.height.equalTo(stepCellHeight/5)
                make.width.equalToSuperview()
            }
        }
        textView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        textView.isEditable = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.font = UIFont(name: "amiri-regular", size: 19)
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(stepCellHeight/3)
//            make.left.equalTo(10)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
