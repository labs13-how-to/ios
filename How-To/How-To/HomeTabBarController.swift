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
        
       
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = #colorLiteral(red: 0.6098504066, green: 0.1598579288, blue: 0.167360574, alpha: 1)
        let redNavController = UINavigationController(rootViewController: redViewController)
        redNavController.tabBarItem.image = #imageLiteral(resourceName: "Home House")
        redNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        redNavController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        let searchController = UISearchController(searchResultsController: nil)
        redViewController.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "How To..."
        
        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = #colorLiteral(red: 0.5765730143, green: 0.8659184575, blue: 0.9998990893, alpha: 1)
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        blueNavController.tabBarItem.image = #imageLiteral(resourceName: "Bullet, List, Text")
        blueNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let darkViewController = UIViewController()
        darkViewController.view.backgroundColor = #colorLiteral(red: 0.3498458862, green: 0.3163031638, blue: 0.3288204372, alpha: 1)
        let darkNavController = UINavigationController(rootViewController: darkViewController)
        darkNavController.tabBarItem.image = #imageLiteral(resourceName: "Bell, Notifications")
        darkNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let orangeViewController = UIViewController()
        orangeViewController.view.backgroundColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        let orangeNavController = UINavigationController(rootViewController: orangeViewController)
        orangeNavController.tabBarItem.image = #imageLiteral(resourceName: "User,Profile")
        orangeNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        viewControllers = [
            redNavController,
            blueNavController,
            darkNavController,
            orangeNavController
        
        ]
    }
}



