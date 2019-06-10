//
//  HomeSearchCollectionViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/2/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PostCell"

class HomeSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let tabBarTag = 0
    
    var howtoController = HowtoController()
    
//    var didSelectHandler: ((Post) -> ())?
    
    
    let headerID = "Header"
    let footerID = "Footer"


    let bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        guard self.navigationController != nil else { fatalError("Navigation Controller not found")}
        //setupTabBar(parentViewController: self, height: view.frame.height / 15, color: .white)
        setupSearchBar(parentViewController: self, color: .white, placeHolderText: "How To...")
        //self.tabBar!.delegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        let searchBar = UISearchBar()
        self.navigationController?.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Settings, Filter"), style: .plain, target: self, action: #selector(openSettings))
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.5493490696, green: 0.5497819781, blue: 0.5494160652, alpha: 1)
        
        collectionView.contentInset = UIEdgeInsets(top:200, left: 0, bottom: 0, right: 0)
//        collectionView?.prefetchDataSource = self
//        fetchPosts()
//        DispatchQueue.main.async {
//            self.postController.getPosts()
//            self.collectionView.reloadData()
//        }
        
        self.howtoController.fetchHowtos(){_ in
            DispatchQueue.main.async {
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
        topView.backgroundColor = UIColor(red:1, green:0.67, blue:0.38, alpha:1)
        
        // Makes Banner Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 30, y: -60, width: 110, height: 28)
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        button.setTitle("Learn How", for: .normal)
        button.setTitleColor(UIColor(red:1, green:0.52, blue:0.1, alpha:1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.layer.shadowColor = #colorLiteral(red: 0.6212611794, green: 0.3437288105, blue: 0.04521131143, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
        
        // Adds views to Collection Super View
        collectionView.insertSubview(topView, at: 0)
        collectionView.insertSubview(button, at: 1)
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
            
                header.addSubview(UILabel(frame:CGRect(x: 12,y: 0,width: view.frame.width,height: 70)))
            
                let lab = header.subviews[0] as! UILabel
                lab.text = "Trending"
                lab.font = .boldSystemFont(ofSize: 23)
                lab.textColor = UIColor(red:1, green:0.52, blue:0.1, alpha:1)
                lab.textAlignment = .left
            
            return header
        }
        if kind == UICollectionView.elementKindSectionFooter {
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.footerID, for: indexPath)
            
            let button = UIButton()
            button.frame = CGRect(x: view.frame.width - 120, y: 16, width: 110, height: 28)
            button.layer.cornerRadius = 6
            button.backgroundColor = .white
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
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        if howtoController.howtos.count > 0 {
            let fetchedPost = self.howtoController.howtos[indexPath.item]
            cell.postID = fetchedPost.id
            cell.titleLabel.text = fetchedPost.title
            // MARK: TODO FIX IMG URL HTTP BUG
//            let imgURL = URL(string: fetchedPost.img_url)
//            cell.imageView.load(url: imgURL!)
            let imgURL = URL(string:"https://picsum.photos/200/300")
//            let imgURL = URL(string: fetchedPost.img_url)
            print(fetchedPost.img_url)
            cell.imageView.load(url: imgURL!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            let updatedAtStr = fetchedPost.created_at
            let updatedAt = dateFormatter.date(from: updatedAtStr) // "Jun 5, 2016, 4:56 PM"
            cell.dateLabel.text = updatedAt?.asString(style: .long)
            cell.parentCollectionVC = self
            
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let postID = howtoController.howtos[indexPath.item].id else {
                fatalError("PostID returned nil")}
        let detailVC = DetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        detailVC.collectionView.backgroundColor = .white
        detailVC.howtoID = postID
        print("\(detailVC.howtoID)")
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
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
        self.navigationItem.titleView = searchController.searchBar // sets searchbar as the titleView of navigation bar to remove unneeded space at the top of the safe area
        guard let navController = self.navigationController else { fatalError() }
        navController.navigationBar.barTintColor = color
        navController.isNavigationBarHidden = false
        searchController.searchBar.placeholder = placeHolderText
    }

}


//extension HomeSearchCollectionViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//
//        }
//    }
//}
