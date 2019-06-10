//
//  LoginViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/6/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import AuthenticationServices
import GoogleSignIn
import UIKit

class LoginViewController: UIViewController {
    
    let buttonBGView: UIView = {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1415234357, green: 0.5382769704, blue: 1, alpha: 1)
        
        // Next 3 lines allow you to choose which corners are rounded on a UIView
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        
        return view
    }()
    
    var loginStatus: Bool = false {
        didSet{
            switchView()
        }
    }

    let signInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 0 , y: 0 , width: 300, height: 60)
        return stackView
    }()
    
    let googleSignInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
        
        // Configure Google Sign-In
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        // GIDSignIn.sharedInstance()?.signIn() will throw an exception if not set.
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        // Attempt to renew a previously authenticated session without forcing the
        // user to go through the OAuth authentication flow.
        // Will notify GIDSignInDelegate of results via sign(_:didSignInFor:withError:)
        GIDSignIn.sharedInstance()?.signInSilently()
        
//        let height = CGFloat(100)
//        let tabBar = UITabBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - height, width: view.frame.width, height: height))
//        let vc = UIViewController()
//        let tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Favorite"), selectedImage: #imageLiteral(resourceName: "Favorite"))
//        tabBar.setItems([tabBarItem], animated: true)
//        self.view.addSubview(tabBar)
        
    }
    
    func setupTabBar(parentViewController: UIViewController, height: CGFloat, color: UIColor ){
        let tabBar = UITabBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - height, width: view.frame.width, height: height))
        parentViewController.view.addSubview(tabBar)
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
            
            viewController.navigationItem.titleView = searchController.searchBar // sets searchbar as the titleView of navigation bar to remove unneeded space at the top of the safe area
            
            navController.navigationBar.barTintColor = .white
            searchController.searchBar.placeholder = "How To..."
            
        } else {
            navController.isNavigationBarHidden = true
        }
        return navController
    }
    
    func setupView(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0.9993286729, green: 0.7073625326, blue: 0.4233144522, alpha: 1)
        let cardHeight = Int(view.frame.height / 3)
        let cardWidth = Int(view.frame.width - 60)
        let cardBGView = UIView()
        let yPoint = Int(view.frame.height / 2) - (cardHeight / 2)
        cardBGView.frame = CGRect(x: 30, y: yPoint, width: cardWidth, height: cardHeight)
        cardBGView.backgroundColor = .white
        cardBGView.layer.cornerRadius = 8
        cardBGView.clipsToBounds = true
        
        view.addSubview(cardBGView)
        cardBGView.addSubview(signInStackView)
        signInStackView.backgroundColor = .black
        signInStackView.axis = .vertical
        signInStackView.spacing = 10
        
       
        signInStackView.addArrangedSubview(googleSignInButton)
        signInStackView.insertSubview(buttonBGView, at: 0)
        signInStackView.centerInSuperview(size: CGSize(width: cardBGView.frame.width - 60, height: 50))
        signInStackView.layer.cornerRadius = 8
        signInStackView.clipsToBounds = true
        
        googleSignInButton.backgroundColor = #colorLiteral(red: 0.1415234357, green: 0.5382769704, blue: 1, alpha: 1)
        googleSignInButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        googleSignInButton.setTitle("Google Sign In", for: .normal)
        googleSignInButton.layer.cornerRadius = 8
        googleSignInButton.clipsToBounds = true
        googleSignInButton.addTarget(self, action: #selector(onGoogleSignInButtonTap), for: .touchUpInside)
    }
    
    
    
    @objc private func onGoogleSignInButtonTap() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    // MARK: - GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        googleSignInButton.isHidden = error == nil
        // A nil error indicates a successful login
        if (error == nil) {
            // Successful login
            // Push Home VC
//        let appDelegate = AppDelegate()
//        appDelegate.window?.rootViewController = HomeTabBarController()
            loginStatus = true
        } else {
            self.loginStatus = false
            print("\(error.localizedDescription)")
        }
        
        
        googleSignInButton.isHidden = error == nil
    }
    
    func switchView() {
        if self.loginStatus == true {
            self.navigationController?.navigationBar.isHidden = true
            let homeTabBar = HomeTabBarController()
            navigationController?.pushViewController(homeTabBar, animated: true)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Make user re-sign in or reload Home Tab Controller
    }
}
//
//class SwitchRoot {
//    let home = HomeTabBarController()
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.window?.rootViewController = home
//}
