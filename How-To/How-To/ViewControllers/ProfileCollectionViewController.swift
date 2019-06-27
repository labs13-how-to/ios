//
//  ProfileCollectionViewController.swift
//  ReviewItYourself
//
//  Created by Angel Buenrostro on 6/13/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "PostCell"

var userName: String?
var isSearching = false

var allPostsByUser: [Howto] = []
var filteredHowtos: [Howto] = []
var tempArray: [Howto] = []

var profileImage = UIImageView()

class ProfileCollectionViewController: UICollectionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        setupSearchBar(parentViewController: self, color: .gray, placeHolderText: "Search...")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings"), style: .plain, target: self, action: #selector(openSettings))
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.5493490696, green: 0.5497819781, blue: 0.5494160652, alpha: 1)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.setRounded()
    }
    func setupView(){
        
        userName = UserDefaults.standard.value(forKey: "username") as? String
        let baseView = UIView()
        self.view.addSubview(baseView)
        let borderView = UIView(frame: CGRect(x: 0, y: 360, width: view.frame.width, height: 1))
        borderView.backgroundColor = .darkGray
        self.view.addSubview(borderView)
        // SHOWS FRAME FOR HEADER, CHANGE FROM WHITE TO SEE THE DIMENSIONS
        baseView.backgroundColor = .white
        baseView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo((navigationController?.navigationBar.frame.maxY)! + 60)
            make.right.equalTo(-20)
            make.height.equalTo(250)
            
        }
        // Need 3 stack views
        let containerStack = UIStackView()
        
        
        // Picture + Username Stack
        let pictureStack = UIStackView()
        pictureStack.axis = .horizontal
        pictureStack.contentMode = .left
        pictureStack.spacing = 20
//        let profilePicture = UIImageView()
//        profilePicture.image = #imageLiteral(resourceName: "ProfilePicture")
//        profilePicture.contentMode = .scaleAspectFill
//        profilePicture.tintColor = #colorLiteral(red: 0.5493490696, green: 0.5497819781, blue: 0.5494160652, alpha: 1)
//        profilePicture.snp.makeConstraints { (make) in
//            make.height.equalTo(100)
//            make.width.equalTo(100)
//        }
//        pictureStack.addArrangedSubview(profilePicture)
        
        // Making the picture rounded
        profileImage.image = #imageLiteral(resourceName: "ProfilePicture")
        profileImage.contentMode = .scaleAspectFill
        profileImage.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        pictureStack.addArrangedSubview(profileImage)
        
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.font = .boldSystemFont(ofSize: 20)

        pictureStack.addArrangedSubview(userNameLabel)
        // Posts + number stack
        let textStack = UIStackView()
        textStack.axis = .vertical
        let blurb = UILabel()
        blurb.numberOfLines = 0
        blurb.text = "blah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blah"
        let postsNumber = UILabel()
        postsNumber.text = "Posts ᐧ 0"
        postsNumber.font = .systemFont(ofSize: 20)
        textStack.spacing = 20
        textStack.alignment = .leading
        
        textStack.addArrangedSubview(blurb)
        textStack.addArrangedSubview(postsNumber)
        // Stack around both stacks
        containerStack.addArrangedSubview(pictureStack)
        containerStack.addArrangedSubview(textStack)
//        containerStack.distribution = .fillEqually
        containerStack.axis = .vertical
        
        baseView.addSubview(containerStack)
        containerStack.fillSuperview(padding: UIEdgeInsets(top: 8, left: 2, bottom: 2, right: 2))
    }
    
    
    func setupBorder(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupView()
        setupBorder()
        collectionView.backgroundColor = .white
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        self.collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func setupSearchBar(parentViewController: UICollectionViewController, color: UIColor, placeHolderText: String){
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = UISearchBar()
        self.navigationController?.navigationItem.titleView = searchBar
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.titleView = searchBar // sets searchbar as the titleView of navigation bar to remove unneeded space at the top of the safe area
        
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if isSearching {
            return filteredHowtos.count
        } else {
            
            if allPostsByUser.count < 8 {
                return allPostsByUser.count
            } else {
                return 8
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
    
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
    
    @objc func openSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.view.backgroundColor = .white
        settingsVC.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    

}


extension ProfileCollectionViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text did change")
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            print("false")
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            isSearching = true
            print("true")
            tempArray = allPostsByUser
            filteredHowtos = tempArray.filter({$0.title.range(of: searchBar.text!, options: .caseInsensitive) != nil })
            collectionView.reloadData()
            collectionView.setNeedsDisplay()
        }
    }
    
}
