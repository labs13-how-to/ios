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
    
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))
        containerView.backgroundColor = .white
        
        
        let youtubeView = WKYTPlayerView()
        containerView.addSubview(youtubeView)
        // Calculates height to ensure 16:9 aspect ratio
        let videoHeight = containerView.frame.width*(9/16)
        
        
        if videoURLString != nil {
            guard let youtubeURL = videoURLString else { fatalError()}
            let youtubeID = youtubeURL.substring(from: 32)
//            youtubeView.lo
            youtubeView.load(withVideoId: youtubeID)
            youtubeView.snp.makeConstraints { make in
                make.top.equalTo(12)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.width.lessThanOrEqualToSuperview()
                make.height.equalTo(videoHeight)
            }
        } else {
                        let imageView = UIImageView()
                        guard let imageURL = URL(string: imgURL!) else {
                            fatalError("No image for post")
                        }
                        //            SUPPOSED TO LOAD FROM BACKEND
                        imageView.load(url: imageURL)
                        imageView.contentMode = .scaleAspectFill
                        containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.width.lessThanOrEqualToSuperview()
                make.height.equalTo(videoHeight + 40)
            }
            
        }
        
        
        // POST TITLE
        let title = UILabel()
        title.font = UIFont(name: "nunito-regular", size: 32)
        title.numberOfLines = 2
        title.text = howtoController.howto?.title
//        title.text = "How to Make a Summer Dress out of Household Items"
        print(title.text)
        
        // STAR RATING
        let starStack = UIStackView()
        starStack.alignment = .center
        starStack.distribution = .fill
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
        ratingLabel.font = UIFont(name: "nunito-regular", size: 20)
        ratingLabel.textColor = #colorLiteral(red: 0.8787388206, green: 0.8787388206, blue: 0.8787388206, alpha: 1)
        let starContainer = UIStackView(arrangedSubviews: [starStack, ratingLabel, UIStackView(), UIStackView()])
        starContainer.alignment = .bottom
        starContainer.spacing = 8
        starContainer.axis = .horizontal
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 260, height: 34))
        print("authorstack")
        nameLabel.text = howto?.username
        nameLabel.font = UIFont(name: "nunito-regular", size: 26)
        
        let introText = UITextView()
        introText.layer.borderWidth = 1
        introText.layer.borderColor = #colorLiteral(red: 0.400000006, green: 0.2199999988, blue: 0.9399999976, alpha: 1)
        introText.text = howtoController.howto?.description
//        introText.text = "The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity."
        introText.font = UIFont(name: "amiri-regular", size: 22)
        var introLength = ((introText.text.count/35)*75)
        print("The introCount is: \(introText.text.count)")
        print("The introLength is: \(introLength)")
        let authorStack = UIStackView(arrangedSubviews: [nameLabel, introText])
        authorStack.axis = .vertical
        authorStack.spacing = 12
        authorStack.alignment = .top
        authorStack.distribution = .fill
        
        // Time title
        let timeHeader = UILabel()
        timeHeader.text = "Time"
        // Time
        let timeLabel = UILabel()
        // Difficulty label
        let difficultyHeader = UILabel()
        difficultyHeader.text = "Difficulty"
        // Difficulty
        let difficultyLabel = UILabel()
        // Tools/Supplies label
        let toolsHeader = UILabel()
        toolsHeader.text = "Tools + Supplies"
        // Tools/Supplies stack of labels
        let toolsTextView = UITextView()
        // Prereqs Label if available
        let prereqsHeader = UILabel()
        prereqsHeader.text = "Prerequisites"
        // Prereqs stack of labels
        let prereqsTextView = UITextView()
        
//        let prereqsStack = UIStackView(arrangedSubviews: [UIView])
//        prereqsStack.axis = .vertical
//        prereqsStack.spacing = 12
//        prereqsStack.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [title, starContainer, authorStack])
        stackView.frame = CGRect(x: 0, y: videoHeight + 10, width: containerView.frame.width, height: 600)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 8
        
        // VIEW CONSTRAINTS
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(videoHeight + 38)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            if introLength < 500 && introLength > 100{
                make.height.equalTo(introLength + 100)
            } else if introLength <= 100{
                make.height.equalTo(300)
            } else {
                make.height.equalTo(600)
            }
            }
        title.snp.makeConstraints { make in
            //            make.right.equalTo(-20)
            make.top.equalTo(8)
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        starContainer.snp.makeConstraints { make in
//            make.top.equalTo(70)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        introText.snp.makeConstraints { make in
            
            make.width.equalToSuperview()
            
            make.height.equalTo(introLength)
            //            if introText.contentSize.height < 500 {
            //                if introText.contentSize.height > 50 {
            //                    make.height.equalTo(introText.contentSize.height + 250)
            //                } else {
            //                    make.height.equalTo(120)
            //                }
            //            } else {
            //                make.height.equalTo(500)
            //            }
        }
        authorStack.snp.makeConstraints { make in
            make.top.equalTo(130)
            make.width.equalToSuperview()
            make.height.equalTo(introLength + 80)
//            make.height.equalTo(480)
//            if introText.contentSize.height < 400 {
//                make.height.equalTo(introText.contentSize.height + 100)
//            } else {
//                make.height.equalTo(480)
//            }
        }
        
       
        
       
        stackView.alignment = .leading
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
            return CGSize(width: view.frame.width, height: 1000)
        }
        return CGSize(width: view.frame.width, height: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView! = nil
        var footer : UICollectionReusableView! = nil
        
        let containerView = UIView(frame: CGRect(x: 0, y: 600, width: view.frame.width, height: 1000))
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


    
