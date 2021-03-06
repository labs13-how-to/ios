//
//  HomeTabBarController.swift
//  How-To
//
//  Created by Angel Buenrostro on 5/31/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//
import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
    }
    
    func setUpViewControllers() {
        viewControllers = [
            createNavController(viewController: HomeSearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "Home House", hasSearch: true),
            createNavController(viewController: TagViewController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "Bullet, List, Text", hasSearch: false),
            createNavController(viewController: ProfileCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "User,Profile", hasSearch: false)
            
        ]
    }
    
    
    fileprivate func createNavController(viewController: UIViewController, imageName: String, hasSearch: Bool) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .white
        
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        if hasSearch {
            let searchController = UISearchController(searchResultsController: nil)
            //MARK: TODO: BUTTON
            let settingsButton = UIButton()
            settingsButton.backgroundColor = .green
            
            navController.navigationItem.titleView = searchController.searchBar // sets searchbar as the titleView of navigation bar to remove unneeded space at the top of the safe area
            navController.isNavigationBarHidden = false
            navController.navigationBar.barTintColor = .white
            searchController.searchBar.placeholder = "How To..."
            
        } else {
            navController.isNavigationBarHidden = true
        }
        return navController
    }
}

