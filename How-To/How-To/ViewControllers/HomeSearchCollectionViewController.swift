//
//  HomeSearchCollectionViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/2/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage



private let reuseIdentifier = "PostCell"

class HomeSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let tabBarTag = 0
    
    var howtoController = HowtoController()
    var allHowtos: [Howto] = []
    var filteredHowtos: [Howto]?
//    {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    var tempArray: [Howto] = []
    
    var isSearching = false
    
//    var didSelectHandler: ((Post) -> ())?
    
    
    let headerID = "Header"
    let footerID = "Footer"


    let bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        let secondNav = self.tabBarController?.viewControllers![1] as! UINavigationController
        let secondTab = secondNav.viewControllers[0] as! TagViewController
        secondTab.allHowtos = self.allHowtos
    }

    override func viewWillAppear(_ animated: Bool) {
        guard self.navigationController != nil else { fatalError("Navigation Controller not found")}
        self.howtoController.howto == nil 
        //setupTabBar(parentViewController: self, height: view.frame.height / 15, color: .white)
//        setupSearchBar(parentViewController: self, color: .white, placeHolderText: "How To...")
        //self.tabBar!.delegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        
        // SET NAVIGATION BAR TO LOGO
        let logoImage = UIImageView()
        logoImage.frame = CGRect(x: 2, y: 2, width: 125, height: 60)
        logoImage.image = #imageLiteral(resourceName: "logo")
        logoImage.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImage
        self.navigationController?.navigationBar.backgroundColor = .white
        
//        let searchBar = UISearchBar()
//        self.navigationController?.navigationItem.titleView = searchBar
//        // SearchBar
//        searchBar.placeholder = "Search..."
//        searchBar.sizeToFit()
//        searchBar.delegate = self
//        searchBar.returnKeyType = UIReturnKeyType.done
//        self.navigationItem.titleView = searchBar // sets searchbar as the titleView of navigation bar to remove unneeded space at the top of the safe area
        guard let navController = self.navigationController else { fatalError() }
        navController.isNavigationBarHidden = false
        
        collectionView.contentInset = UIEdgeInsets(top:200, left: 0, bottom: 0, right: 0)
//        collectionView?.prefetchDataSource = self
//        fetchPosts()
//        DispatchQueue.main.async {
//            self.postController.getPosts()
//            self.collectionView.reloadData()
//        }
        
        self.howtoController.fetchHowtos(){_ in
            DispatchQueue.main.async {
                self.allHowtos = self.howtoController.howtos
                self.collectionView.reloadData()
            }
        }
        
        // Register cell classes
        self.collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        self.collectionView.register(Footer.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        

        // Do any additional setup after loading the view.
        setUpViews()
    }
    

    func setUpViews(){
        
        // Makes Top Banner
        let topView = UIView()
        topView.frame = CGRect(x:0, y:-200, width:(view.frame.width + 40), height:200)
        topView.backgroundColor = #colorLiteral(red: 0.9994708896, green: 0.8877617717, blue: 0.7884737849, alpha: 1)
        
        // Makes Banner Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 30, y: -60, width: 110, height: 28)
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        button.setTitle("Learn How", for: .normal)
        button.setTitleColor(UIColor(red:1, green:0.52, blue:0.1, alpha:1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.layer.shadowColor = #colorLiteral(red: 0.9993600249, green: 0.5205107927, blue: 0.1008351222, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
        
        // Make Text Label
        let splashText = UILabel()
        splashText.text = "Never made an RIY post before? We'll help you learn how."
        splashText.frame = CGRect(x: 30, y: -160, width: 220, height: 80)
        splashText.numberOfLines = 0
        splashText.textColor = #colorLiteral(red: 0.3245337605, green: 0.3248056173, blue: 0.3245758414, alpha: 1)
        splashText.font = .systemFont(ofSize: 21)
        // Make Image on Top View
        let splashImage = UIImageView()
        splashImage.image = #imageLiteral(resourceName: "CleanShot 2019-06-26 at 03.07.08")
        splashImage.frame = CGRect(x: 270, y: -186, width: 100, height: 170)
        splashImage.contentMode = .scaleAspectFit
        splashImage.layer.cornerRadius = 8
        splashImage.clipsToBounds = true
        // Adds views to Collection Super View
        collectionView.insertSubview(topView, at: 0)
        collectionView.insertSubview(button, at: 1)
        collectionView.insertSubview(splashText, at: 2)
        collectionView.insertSubview(splashImage, at: 3)
        pinBackground(bgColorView, to: view)
        collectionView.backgroundColor = bgColorView.backgroundColor
        
    }
  
    // MARK: HEADER
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header : UICollectionReusableView! = nil
        var footer : UICollectionReusableView! = nil
        
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
            
            if indexPath.row == 0 {
                
                header.addSubview(UILabel(frame:CGRect(x: 12,y: 0,width: view.frame.width,height: 70)))
                
                let lab = header.subviews[0] as! UILabel
                lab.text = "Trending"
                lab.font = UIFont(name: "nunito-regular", size: 25)
                lab.textColor = UIColor(red:1, green:0.52, blue:0.1, alpha:1)
                lab.textAlignment = .left
            }
            
            
            return header
        }
        if kind == UICollectionView.elementKindSectionFooter {
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerID, for: indexPath)
            
            let button = UIButton()
            button.frame = CGRect(x: view.frame.width - 120, y: 16, width: 110, height: 28)
            button.layer.cornerRadius = 6
            button.backgroundColor = .white
            // SET FOOTER TEXT
            button.setTitle("See More", for: .normal)
            button.setTitleColor(UIColor(red:1, green:0.52, blue:0.1, alpha:1), for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            
            footer.insertSubview(button, at: 0)
            
            return footer
        }
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.frame.width >= 375 {
            return (CGSize(width: (collectionView.frame.width/2) - 36, height: (collectionView.frame.height/3)))
        }
        return CGSize(width: (collectionView.frame.width) - 36, height: (collectionView.frame.height/3))
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if isSearching {
            return filteredHowtos!.count
        } else {
        
            if allHowtos.count < 8 {
                return allHowtos.count
            } else {
                return 8
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        var fetchedPost: Howto?
        if isSearching {
            fetchedPost = self.filteredHowtos![indexPath.item]
        } else {
            fetchedPost = self.allHowtos[indexPath.item]
        }
            if fetchedPost != nil {
                cell.postID = fetchedPost?.id
                cell.titleLabel.text = fetchedPost?.title
                cell.rating = fetchedPost!.review_avg!
                print("RATING: \(Int(fetchedPost!.review_avg!))")
                let imgURL = URL(string: fetchedPost!.img_url!)
                
                cell.imageView.sd_setImage(with: imgURL)
//                print(fetchedPost!.img_url)
//                cell.imageView.load(url: imgURL!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                let updatedAtStr = fetchedPost!.created_at
                let updatedAt = dateFormatter.date(from: updatedAtStr) // "Jun 5, 2016, 4:56 PM"
                cell.dateLabel.text = updatedAt?.asString(style: .long)
                cell.parentCollectionVC = self
                cell.howto = fetchedPost
            }
        return cell
        }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let howto = howtoController.howtos[indexPath.item]
        guard let postID = howto.id else {
            fatalError("PostID returned nil")
        }
                
                let detailVC = DetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
                detailVC.collectionView.backgroundColor = .white
                detailVC.howtoID = postID
                detailVC.imgURL = howto.img_url
                detailVC.rating = howto.review_avg
                detailVC.reviewCount = howto.review_count!
                detailVC.videoURLString = howto.vid_url
                self.navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
    

    
    
    
    // Hides TabBar when user scrolls down
    //    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
    //            changeTabBar(hidden: true, animated: true)
    //        }
    //        else{
    //            changeTabBar(hidden: false, animated: true)
    //        }
    //    }
    func loadHowTo(cell: PostCell){
        
    }
    @objc func openSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.view.backgroundColor = .white
        settingsVC.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    
    // Helper method which pins a bgColor to the very back of our screen
    func pinBackground(_ view: UIView, to superView: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        superView.insertSubview(view, at: 0)
        view.pin(to: superView)
    }
    
    // Helper which setsUp initial TabBar frame
//    func setupTabBar(parentViewController: UICollectionViewController, height: CGFloat, color: UIColor ){
//        let tabBar = UITabBar(frame: CGRect(x: 0, y: view.frame.maxY - height, width: view.frame.width, height: height))
//        tabBar.backgroundColor = color
//        parentViewController.view.addSubview(tabBar)
//        self.tabBar = tabBar
//        let homeTab = UITabBarItem(title: "", image: #imageLiteral(resourceName: "Home House"), tag: 0)
//        let tagsTab = UITabBarItem(title:"", image: #imageLiteral(resourceName: "Bullet, List, Text"), tag: 1)
//        let notificationsTab = UITabBarItem(title: "", image: #imageLiteral(resourceName: "Bell, Notifications"), tag: 2)
//        let profileTab = UITabBarItem(title: "", image: #imageLiteral(resourceName: "User,Profile"), tag: 3)
//        tabBar.setItems([homeTab, tagsTab, notificationsTab, profileTab], animated: true)
//    }
    
    func setupSearchBar(parentViewController: UICollectionViewController, color: UIColor, placeHolderText: String){
        let searchController = UISearchController(searchResultsController: nil)
        
        
        print("searchbar setup")
    }
    

}

extension HomeSearchCollectionViewController: UISearchBarDelegate{
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
            tempArray = allHowtos
            filteredHowtos = tempArray.filter({$0.title.range(of: searchBar.text!, options: .caseInsensitive) != nil })
            collectionView.reloadData()
            collectionView.setNeedsDisplay()
        }
    }
    
}


//extension HomeSearchCollectionViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//
//        }
//    }
//}
