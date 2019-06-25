//
//  DetailCollectionViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit
import YoutubePlayer_in_WKWebView

private let reuseIdentifier = "DetailCell"

class DetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var howtoController = HowtoController()
    var howto: Howto?
    var howtoID: Int?
    var imgURL: String?
    var rating: Double?
    var reviewCount: Int?
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "hey"
        return label
        
    }()
    
    var videoURLString: String?
    
    let headerID = "Header"
    let footerID = "Footer"
    
    
//    convenience init?(collectionViewLayout layout: UICollectionViewLayout, ID: Int) {
//        self.init(coder: NSCoder())
//        self.postID = ID
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.howtoController.howto == nil {
            self.howtoController.fetchHowto(id: howtoID!) {_ in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
    //                self.setupHeader()
                    if self.howtoController.howto == nil {
                        fatalError()
                    }
                    self.howto = self.howtoController.howto
                    print("view will appear")
                    print(self.howto?.username)
                }
            }
            
        }
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        collectionView.backgroundColor = #colorLiteral(red: 0.5765730143, green: 0.8659184575, blue: 0.9998990893, alpha: 1)
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 400, right: 0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(HowtoDetailCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.register(Footer.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        // Do any additional setup after loading the view.
    }
    
    
    func setupHeader() -> UIView{
    
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 600))
        containerView.backgroundColor = #colorLiteral(red: 0.638515234, green: 0.6041640639, blue: 0.7091518044, alpha: 1)
        
        
        let youtubeView = WKYTPlayerView()
        containerView.addSubview(youtubeView)
        // Calculates height to ensure 16:9 aspect ratio
        let videoHeight = containerView.frame.width*(9/16)
        if videoURLString == nil {
            //            youtubeView.cueVideo(byURL: videoURLString!, startSeconds: 0, suggestedQuality: .HD720)
            youtubeView.load(withVideoId: "bVQqHC9ZRm8")
            youtubeView.snp.makeConstraints { make in
                make.top.equalTo(12)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.width.lessThanOrEqualToSuperview()
                make.height.equalTo(videoHeight)
            }
        } else {
            //            let imageView = UIImageView()
            //            guard let imageURL = URL(string: imgURL!) else {
            //                fatalError("No image for post")
            //            }
            //            //            SUPPOSED TO LOAD FROM BACKEND
            //            imageView.load(url: imageURL)
            //            imageView.constrainWidth(constant: collectionView.frame.width)
            //            imageView.contentMode = .scaleAspectFit
            //            stackView.addSubview(title)
            //            stackView.addSubview(imageView)
            
        }
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 0, y: videoHeight + 20, width: containerView.frame.width, height: 600)

        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 8
        
        
        // POST TITLE
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        title.font = .systemFont(ofSize: 27)
        title.numberOfLines = 0
        title.text = howtoController.howto?.title
        print(title.text)
        stackView.addSubview(title)
        
        // STAR RATING
        let starStack = UIStackView()
        starStack.alignment = .leading
        starStack.distribution = .equalCentering
        var starRating : [UIImageView] = []
        let roundedRating = Int((rating?.rounded())!)
        print(roundedRating)
        if rating != 0 {
            for _ in 0...roundedRating-1 {
                let fullStar = UIImageView()
                fullStar.image = #imageLiteral(resourceName: "Solid Star")
                fullStar.tintColor = #colorLiteral(red: 0.9843137264, green: 0.7084275484, blue: 0.160784319, alpha: 1)
                fullStar.snp.makeConstraints { (make) in
                    make.width.equalTo(24)
                    make.height.equalTo(24)
                }
                starStack.addArrangedSubview(fullStar)
            }
            if roundedRating < 5 {
            for _ in starStack.subviews.count...4 {
                let emptyStar = UIImageView()
                emptyStar.image = #imageLiteral(resourceName: "Solid Star")
                emptyStar.tintColor = #colorLiteral(red: 0.8787388206, green: 0.8787388206, blue: 0.8787388206, alpha: 1)
                emptyStar.snp.makeConstraints { (make) in
                    make.width.equalTo(24)
                    make.height.equalTo(24)
                }
                starStack.addArrangedSubview(emptyStar)
            }
        }
        }   else {
            for _ in 0...4 {
                let emptyStar = UIImageView()
                emptyStar.image = #imageLiteral(resourceName: "Solid Star")
                emptyStar.tintColor = #colorLiteral(red: 0.8787388206, green: 0.8787388206, blue: 0.8787388206, alpha: 1)
                emptyStar.snp.makeConstraints { (make) in
                    make.width.equalTo(24)
                    make.height.equalTo(24)
                }
                starStack.addArrangedSubview(emptyStar)
            }
        }
        let ratingLabel = UILabel()
        var unwrappedReviewCount = 0
        if reviewCount != nil {
            unwrappedReviewCount = reviewCount!
        }
        ratingLabel.text = ("∙ " + String(unwrappedReviewCount) + " " + "reviews")
        ratingLabel.font = .systemFont(ofSize: 16)
        ratingLabel.textColor = #colorLiteral(red: 0.8787388206, green: 0.8787388206, blue: 0.8787388206, alpha: 1)
        let starContainer = UIStackView(arrangedSubviews: [starStack, ratingLabel, UIStackView(), UIStackView()])
        starContainer.spacing = 8
//        starContainer.distribution = .equalSpacing
        stackView.addSubview(starContainer)
        starContainer.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
//        containerView.addSubview(youtubeView)
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(videoHeight + 6)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        let authorStack = UIStackView()
        let nameLabel = UILabel()
        print("authorstack")
        print(howto?.username)
        nameLabel.text = howto?.username
        authorStack.addSubview(nameLabel)
        containerView.addSubview(authorStack)
        authorStack.snp.makeConstraints { make in
            make.top.equalTo(450)
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
        containerView.setNeedsDisplay()
        return containerView
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 600)
        }
        return CGSize(width: view.frame.width, height: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView! = nil
        var footer : UICollectionReusableView! = nil
        
        let containerView = UIView(frame: CGRect(x: 0, y: 600, width: view.frame.width, height: 600))
        containerView.backgroundColor = #colorLiteral(red: 0.638515234, green: 0.6041640639, blue: 0.7091518044, alpha: 1)
        
            if kind == UICollectionView.elementKindSectionHeader {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
                header.backgroundColor = #colorLiteral(red: 0.9213851094, green: 0.5346282125, blue: 0.7493482828, alpha: 1)
                
                header.addSubview(setupHeader())
                
                return header
        }
        
            if kind == UICollectionView.elementKindSectionFooter {
                footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerID, for: indexPath)
                
                footer.backgroundColor = #colorLiteral(red: 0.6899999976, green: 0.9599999785, blue: 0.400000006, alpha: 1)
               
                
                return footer
            }
        
         return header
    }
    // MARK: - Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            
            return CGSize(width: view.frame.width, height: 300)
        }
        return CGSize(width: 0, height: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24)
        } else {
            return UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24)
        }
        
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            guard let steps = howtoController.howto?.steps else { return 2 }
            return steps.count
        }
        if section == 1 {
            guard let reviewCount = howtoController.howto?.review_count else { return 1 }
            return reviewCount
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HowtoDetailCollectionViewCell
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


    
