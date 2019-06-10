//
//  MasterNavigationController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/8/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class MasterNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTabBar(parentViewController: UIViewController(), height: 100, color: .red)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setupTabBar(parentViewController: UIViewController, height: CGFloat, color: UIColor ){
        let tabBar = UITabBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - height, width: view.frame.width, height: height))
        tabBar.backgroundColor = color
        parentViewController.view.addSubview(tabBar)
    }

}
