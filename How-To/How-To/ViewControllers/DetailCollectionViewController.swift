//
//  DetailCollectionViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

private let reuseIdentifier = "DetailCell"

class DetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var howtoController = HowtoController()
    var howtoID: Int?
    var imgURL: String?
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "hey"
        return label
        
    }()
    
    var videoURLString: String?
    
    let headerID = "Header"
    
    
//    convenience init?(collectionViewLayout layout: UICollectionViewLayout, ID: Int) {
//        self.init(coder: NSCoder())
//        self.postID = ID
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.howtoController.fetchHowto(id: howtoID!) {_ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.howtoController.fetchHowto(id: self.howtoID!){_ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        view.addSubview(label)
        guard let howTo = self.howtoController.howto else { return }
        label.text = howTo.title
    }
    
    func setupHeader()-> UIView {
    
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 600))
        containerView.backgroundColor = .white
//        containerView.backgroundColor = #colorLiteral(red: 0.9213851094, green: 0.5346282125, blue: 0.7493482828, alpha: 1)
        
        
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 0, y: containerView.frame.maxY - 300, width: containerView.frame.width, height: 600)
        
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.contentMode = .scaleToFill
        stackView.spacing = 0
        let title = UILabel()
        title.text = howtoController.howto?.title
        print(title.text)
        
        let youtubeView = WKYTPlayerView(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
        if videoURLString != nil {
//            youtubeView.cueVideo(byURL: videoURLString!, startSeconds: 0, suggestedQuality: .HD720)
            youtubeView.load(withVideoId: "bVQqHC9ZRm8")
            stackView.addSubview(youtubeView)
        } else {
            let imageView = UIImageView()
            guard let imageURL = URL(string: imgURL!) else {
                fatalError("No image for post")
            }
            //            SUPPOSED TO LOAD FROM BACKEND
            imageView.load(url: imageURL)
            imageView.constrainWidth(constant: collectionView.frame.width)
            imageView.contentMode = .scaleAspectFit
            stackView.addSubview(title)
            stackView.addSubview(imageView)
            
        }
        containerView.addSubview(stackView)
//        containerView.setNeedsDisplay()
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
        return CGSize(width: view.frame.width, height: 600)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header: UICollectionReusableView! = nil
        
            if kind == UICollectionView.elementKindSectionHeader {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
                
//                header.addSubview(setupHeader())
                
            
        }
         return header
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            guard let steps = howtoController.howto?.steps else { return 2 }
            return steps.count
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


    
