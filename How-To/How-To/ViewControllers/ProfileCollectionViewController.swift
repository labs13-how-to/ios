//
//  ProfileCollectionViewController.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/13/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProfileCollectionViewController: UICollectionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 600))
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        if let profileImageURL = UserDefaults.standard.value(forKey: "profileImageURL") as? URL {
            
            profileImage.load(url: (profileImageURL))
            stackView.addSubview(profileImage)
        } else {
            profileImage.backgroundColor = .lightGray
        }
        nameLabel.text = UserDefaults.standard.value(forKey: "firstName") as? String
        print(nameLabel.text)
        stackView.addSubview(nameLabel)
        stackView.axis = .vertical
        collectionView.addSubview(stackView)
        collectionView.setNeedsDisplay()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
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
