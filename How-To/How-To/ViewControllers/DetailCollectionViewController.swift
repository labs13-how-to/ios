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
    
    var screenWidth = 0
    var youtubeID = "1"
    var videoURLString: String?
    
    let headerID = "Header"
    let footerID = "Footer"
    var reviews : [PostReview]? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("\(self.reviews!.count)")
            }
        }
    }
    
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
                    guard let id = self.howto?.id else { fatalError() }
    
                    self.howtoController.fetchReviews(id: (id)) {_ in
                        self.reviews = self.howtoController.reviews
                    }
                    
                }
                
            }
            
        }
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        screenWidth = Int(view.frame.width)

        // Register cell classes
        self.collectionView!.register(HowtoDetailCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.register(ReviewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        // Do any additional setup after loading the view.
    }
    
    
    func setupHeader() -> UIView{
    
//        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1200))
        let containerView = UIView()
        
//        containerView.layer.borderWidth = 0
//        containerView.layer.borderColor = #colorLiteral(red: 0.2899999917, green: 0.9499999881, blue: 0.6299999952, alpha: 1)
        
        let youtubeView = WKYTPlayerView()
        let imageView = UIImageView()
        containerView.addSubview(youtubeView)
        // Calculates height to ensure 16:9 aspect ratio
        let videoHeight = view.frame.width*(9/16)
        
        if videoURLString != nil {
            guard let youtubeURL = videoURLString else { fatalError()}
//            let testURL = "https://www.youtube.com/watch?v=0Jb29c22xu8"
            var subStringArray = youtubeURL.components(separatedBy: "=")
            if subStringArray.count > 1 {
                youtubeID = subStringArray[1]
                print("youtubeID: \(youtubeID)")
                //            let youtubeID = "0Jb29c22xu8"  // FOR TESTING
                youtubeView.load(withVideoId: youtubeID)
                youtubeView.snp.makeConstraints { make in
                    make.top.equalTo(12)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                    make.width.equalTo(view.frame.width)
                    make.height.equalTo(videoHeight)
                }

            } else {
                guard let imageURL = URL(string: imgURL!) else {
                    fatalError("No image for post")
                }
                //            SUPPOSED TO LOAD FROM BACKEND
                imageView.load(url: imageURL)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                
                containerView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.width.equalTo(view.frame.width)
                    make.height.equalTo(videoHeight + 40)
                    make.centerX.equalToSuperview()
                }
            }
        } else {
        
                        guard let imageURL = URL(string: imgURL!) else {
                            fatalError("No image for post")
                        }
                        //            SUPPOSED TO LOAD FROM BACKEND
                        imageView.load(url: imageURL)
                        imageView.contentMode = .scaleAspectFill
                        imageView.clipsToBounds = true
            
                        containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.width.equalTo(view.frame.width)
                make.height.equalTo(videoHeight + 40)
                make.centerX.equalToSuperview()
            }
            
        }
        
        
        // POST TITLE
        let title = UILabel()
        title.font = UIFont(name: "nunito-regular", size: 26)
        title.numberOfLines = 0
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
                fullStar.image = #imageLiteral(resourceName: "Star")
                fullStar.tintColor = #colorLiteral(red: 0.9843137264, green: 0.7084275484, blue: 0.160784319, alpha: 1)
                fullStar.snp.makeConstraints { (make) in
                    make.height.width.equalTo(24)
                }
                starStack.addArrangedSubview(fullStar)
            }
            if roundedRating < 5 {
            for _ in starStack.subviews.count...4 {
                let emptyStar = UIImageView()
                emptyStar.image = #imageLiteral(resourceName: "Star")
                emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
                emptyStar.snp.makeConstraints { (make) in
                    make.height.width.equalTo(24)
                }
                starStack.addArrangedSubview(emptyStar)
            }
        }
        }   else {
            for _ in 0...4 {
                let emptyStar = UIImageView()
                emptyStar.image = #imageLiteral(resourceName: "Star")
                emptyStar.tintColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
                emptyStar.snp.makeConstraints { (make) in
                    make.height.width.equalTo(24)
                }
                starStack.addArrangedSubview(emptyStar)
            }
        }
        let ratingLabel = UILabel()
        ratingLabel.font = UIFont(name: "nunito-regular", size: 18)
        guard let unwrappedCount = reviewCount else { fatalError() }
        if unwrappedCount == 1 {
            ratingLabel.text = ("∙ " + "\(Int(unwrappedCount))" + " Review")
        } else {
            ratingLabel.text = ("∙ " + "\(Int(unwrappedCount))" + " Reviews")
        }
        
        
        let starContainer = UIStackView(arrangedSubviews: [starStack, ratingLabel, UIStackView(), UIStackView()])
        starContainer.alignment = .center
        starContainer.spacing = 8
        starContainer.axis = .horizontal
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 260, height: 34))
        print("authorstack")
        nameLabel.text = howto?.username
        nameLabel.font = UIFont(name: "nunito-regular", size: 22)
        
        let introText = UITextView()
        
        introText.isEditable = false
        
        introText.backgroundColor = .white
        introText.layer.borderWidth = 1
        introText.layer.borderColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        introText.layer.cornerRadius = 10
        introText.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        

        
        introText.text = howtoController.howto?.description
//        introText.text = "The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity.The term do-it-yourself has been associated with consumers since at least 1912 primarily in the domain of home improvement and maintenance activities. in reference to the emergence of a trend of people undertaking home improvement and various other small craft and construction projects as both a creative-recreational and cost-saving activity."
        introText.font = UIFont(name: "amiri-regular", size: 21)
//        var introLength = ((introText.text.count/35)*75)
        var introLength = 500
        print("The introCount is: \(introText.text.count)")
        print("The introLength is: \(introLength)")
        let authorStack = UIStackView(arrangedSubviews: [nameLabel, introText])
        authorStack.axis = .vertical
        authorStack.spacing = 12
        authorStack.alignment = .top
        authorStack.distribution = .fill
        
        // Time title
        let timeHeader = UILabel()
        styleHeader(header: timeHeader)
        timeHeader.text = "Time"
        // Time
        let timeLabel = UILabel()
        styleMiscellaneous(label: timeLabel)
        timeLabel.text = howtoController.howto?.duration
        // Difficulty label
        let difficultyHeader = UILabel()
        styleHeader(header: difficultyHeader)
        difficultyHeader.text = "Difficulty"
        // Difficulty
        let difficultyLabel = UILabel()
        styleMiscellaneous(label: difficultyLabel)
        difficultyLabel.text = howtoController.howto?.difficulty
        // Tools/Supplies label
        let toolsHeader = UILabel()
        styleHeader(header: toolsHeader)
        toolsHeader.text = "Tools + Supplies"
        // Tools/Supplies stack of labels
        let toolsLabel = UILabel()
        styleMiscellaneous(label: toolsLabel)
        var suppliesString = ""
        if howtoController.howto?.supplies != nil {
            suppliesString = howtoController.howto!.supplies!
        }
        var toolsStringArray = suppliesString.components(separatedBy: " _ ")
        let toolsJoined = toolsStringArray.joined(separator: "\n")
        toolsLabel.text = toolsJoined
        toolsLabel.numberOfLines = 0
        // Prereqs Label if available
        let prereqsHeader = UILabel()
        styleHeader(header: prereqsHeader)
        prereqsHeader.text = "Prerequisites"
        // Prereqs stack of labels
        let prereqsLabel = UILabel()
        styleMiscellaneous(label: prereqsLabel)
        prereqsLabel.text = howtoController.howto?.skills
        prereqsLabel.numberOfLines = 0
        let miscelleanousStack = UIStackView(arrangedSubviews: [timeHeader, timeLabel, difficultyHeader, difficultyLabel, toolsHeader, toolsLabel, prereqsHeader, prereqsLabel])
        miscelleanousStack.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: 500)
        miscelleanousStack.axis = .vertical
        miscelleanousStack.layer.borderWidth = 1
        miscelleanousStack.layer.borderColor = #colorLiteral(red: 0.9213851094, green: 0.5346282125, blue: 0.7493482828, alpha: 1)
        miscelleanousStack.distribution = .equalSpacing
        miscelleanousStack.spacing = 6
        
        let miscellaneousScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width, height: 500))
        miscellaneousScrollView.layer.borderWidth = 1
        miscellaneousScrollView.layer.cornerRadius = 10
        miscellaneousScrollView.layer.borderColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        miscellaneousScrollView.backgroundColor = .white
        miscellaneousScrollView.addSubview(miscelleanousStack)
        miscellaneousScrollView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        
        miscelleanousStack.topAnchor.constraint(equalTo: miscellaneousScrollView.topAnchor).isActive = true
        miscelleanousStack.leadingAnchor.constraint(equalTo: miscellaneousScrollView.leadingAnchor).isActive = true
        miscelleanousStack.trailingAnchor.constraint(equalTo: miscellaneousScrollView.trailingAnchor).isActive = true
        miscelleanousStack.bottomAnchor.constraint(equalTo: miscellaneousScrollView.bottomAnchor).isActive = true

        miscelleanousStack.widthAnchor.constraint(equalTo: miscellaneousScrollView.widthAnchor, constant: -40).isActive = true
        
//        let prereqsStack = UIStackView(arrangedSubviews: [UIView])
//        prereqsStack.axis = .vertical
//        prereqsStack.spacing = 12
//        prereqsStack.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [title, starContainer, authorStack])
        stackView.frame = CGRect(x: 0, y: videoHeight + 10, width: containerView.frame.width, height: 600)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 8
        
        let bgTextView = UIView()
        bgTextView.backgroundColor = .white
        
        // VIEW CONSTRAINTS
        containerView.addSubview(bgTextView)
        containerView.addSubview(stackView)
        containerView.addSubview(miscellaneousScrollView)
//        containerView.addSubview(miscelleanousStack)
        
        bgTextView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(introText.snp_topMargin).offset(-20)
            make.bottom.equalTo(miscellaneousScrollView.snp_bottomMargin).offset(20)
        }
        
        miscellaneousScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(introText.snp_bottomMargin).offset(26)
            make.right.equalTo(-20)
            make.left.equalTo(20)
            make.height.equalTo(300)
        }
        
        miscelleanousStack.snp.makeConstraints { (make) in
//            make.top.equalTo(stackView.bounds.maxY + 290)
//            make.top.equalTo(introText.snp_bottomMargin).offset(26)
            make.left.equalTo(20)
            make.right.equalTo(-20)
//            make.height.equalTo(500)
        }
        
        stackView.snp.makeConstraints { make in
            if youtubeID.count > 1 {
                make.top.equalTo(youtubeView.snp_bottomMargin)
            } else {
                make.top.equalTo(270)
            }
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
            
            
            make.top.equalTo(nameLabel.snp_bottomMargin)
            make.left.right.equalToSuperview()
            
//            make.width.equalTo(view.frame.width+40)
//
//            make.height.equalTo(introLength)
            
            
            
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
        
        // TIME, DIFFICULTY, TOOLS, PREREQS
        
//        let info
        containerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(self.collectionView.subviews[0].frame.maxY)
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
            return CGSize(width: view.frame.width, height: 1200)
        }
        return CGSize(width: view.frame.width, height: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView! = nil
        var footer : ReviewFooter! = nil
        
        let containerView = UIView(frame: CGRect(x: 0, y: 600, width: view.frame.width, height: 1200))
        containerView.backgroundColor = #colorLiteral(red: 0.638515234, green: 0.6041640639, blue: 0.7091518044, alpha: 1)
        
            if kind == UICollectionView.elementKindSectionHeader {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
                
                header.addSubview(setupHeader())
                
                return header
        }
        
            if kind == UICollectionView.elementKindSectionFooter {
                footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerID, for: indexPath) as! ReviewFooter
                    footer.backgroundColor = .white
                if  howtoController.reviews != nil {
                    footer.reviews = self.reviews!
                    
                }
                    footer.howto = self.howto
                    footer.addSubview(setupFooterBars())
                    footer.backgroundColor = #colorLiteral(red: 0.6899999976, green: 0.9599999785, blue: 0.400000006, alpha: 1)
//                let stackView = UIStackView(arrangedSubviews: [setupFooterBars(), setupFooterReviews()])
//                stackView.axis = .vertical
//
//                footer.addSubview(stackView)
//                stackView.fillSuperview()
                
                return footer
            }
        
         return header
    }
    func setupFooterBars() -> UIView {
        let barsContainer = UIView(frame: CGRect(x: 50, y: 0, width: screenWidth, height: 500))
        
        let barsStack = UIStackView()
        
        
        
        
        let reviewBG = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        reviewBG.backgroundColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        let reviewLabel = UILabel(frame: CGRect(x: 14, y: 0, width: view.frame.width - 28, height: 50))
        reviewLabel.text = "Reviews"
        reviewLabel.font = UIFont(name: "nunito-bold", size: 28)
        reviewLabel.textColor = .white
        reviewBG.addSubview(reviewLabel)
        barsContainer.addSubview(reviewBG)
        
        barsContainer.backgroundColor = .white
        barsContainer.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(250)
        }
        
        barsContainer.addSubview(barsStack)
        barsStack.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 200)
        
        let barBG = UIView()
        barBG.backgroundColor = .purple
        barsStack.addSubview(barBG)
        barBG.fillSuperview()
        let ratingFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        let testBar = RatingBar(frame: ratingFrame, percentage: 0.5)
        barsStack.addSubview(testBar)
        
        let verticalBarStack = UIStackView(frame: CGRect(x: 0, y: reviewLabel.frame.height, width: view.frame.width, height: view.frame.height))
        verticalBarStack.axis = .vertical
        barsContainer.addSubview(verticalBarStack)
        verticalBarStack.fillSuperview()
        verticalBarStack.distribution = .equalSpacing
        
        var yValue = 0
        var starValue = 5
        var fiveStarPercentage = 0
        if self.reviews!.count > 0 {
            let count = self.reviews!.count
            let fiveStarCount = self.reviews?.filter({$0.rating == 5})
            fiveStarPercentage = fiveStarCount!.count/count
        }
        
//        for _ in 0...4 {
//            let starNumberLabel = UILabel(frame: CGRect(x: 0, y: yValue, width: 50, height: 30))
//            starNumberLabel.backgroundColor = .white
//            starNumberLabel.text = String(starValue) + " Stars"
//            starNumberLabel.font = UIFont(name: "nunito-regular", size: 15)
//            let barView = RatingBar(frame: CGRect(x: Int(starNumberLabel.frame.width), y: yValue, width: screenWidth-80, height: 30))
//            barView.width = screenWidth-80
//            barView.percentage = CGFloat(fiveStarPercentage)
//            barView.backgroundColor = #colorLiteral(red: 0.9212495685, green: 0.9219488502, blue: 0.9213578105, alpha: 1)
//            barView.layer.cornerRadius = 10
//            let reviewCountLabel = UILabel(frame: CGRect(x: Int(barView.frame.width + starNumberLabel.frame.width), y: yValue, width: 50, height: 30))
////            reviewCountLabel.text = "1"
//            reviewCountLabel.backgroundColor = .white
//            let starBarStack = UIStackView()
//            verticalBarStack.addSubview(starBarStack)
//            starBarStack.snp.makeConstraints { (make) in
//                make.width.equalToSuperview()
//                make.height.equalTo(40)
//                make.topMargin.equalTo(reviewBG.snp_bottomMargin).offset(20)
//                make.leftMargin.equalTo(16)
//            }
//            starBarStack.addSubview(starNumberLabel)
//            starBarStack.addSubview(barView)
//            starBarStack.addSubview(reviewCountLabel)
//            
//            fiveStarPercentage = 0
//            yValue += 35
//            starValue -= 1
//        }
        
        return barsContainer
    }
    
    func setupFooterReviews()-> UIView{
        let containerView = UIView()
        
        containerView.backgroundColor = .red
        // Add Stripe Header
        
        // Add Bars for ratings
        
        // Add Review Button STRETCH
        
        // Add Reviews Cells
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        containerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(400)
        }
        
        let horizontalReviewController = ReviewsHorizontalController(collectionViewLayout: UICollectionViewFlowLayout())
        horizontalReviewController.howto = self.howto
        containerView.addSubview(horizontalReviewController.view)
        horizontalReviewController.view.fillSuperview()
        horizontalReviewController.view.backgroundColor = .blue
        return containerView
        
    }
    
    
    // MARK: - Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            
            if howto?.reviews?.count == 0 {
                return CGSize(width: view.frame.width, height: 250)
            }
            
            return CGSize(width: view.frame.width, height: 600)
            
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if howto?.steps?.count == 0 {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
//            guard let steps = howtoController.howto?.steps else { return 2 }
//            return steps.count
            return 1
        }
        if section == 1 {
//            guard let reviewCount = howtoController.howto?.review_count else { return 1 }
//            return reviewCount
            return 1
        }
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HowtoDetailCollectionViewCell
        cell.howto = self.howto
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
    
    func styleHeader(header: UILabel){
        header.font = UIFont(name: "nunito-regular", size: 25)
        header.textColor = #colorLiteral(red: 0.9993600249, green: 0.5205107927, blue: 0.1008351222, alpha: 1)
    }
    func styleMiscellaneous(label: UILabel){
        label.font = UIFont(name: "nunito-regular", size: 18)
        label.textColor = #colorLiteral(red: 0.3330089152, green: 0.333286792, blue: 0.3330519199, alpha: 1)
    }

}


    
