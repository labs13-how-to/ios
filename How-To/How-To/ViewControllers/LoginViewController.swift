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
    
    let userController = UserController()
    var screenwidth = 0
    let buttonBGView: UIView = {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1415234357, green: 0.5382769704, blue: 1, alpha: 1)
        
        // Next 3 lines allow you to choose which corners are rounded on a UIView
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        
        return view
    }()

    let signInStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 0 , y: 0 , width: 300, height: 60)
        return stackView
    }()
    
    let googleSignInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenwidth = Int(view.frame.width)
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
        
        let logo = UIImageView(frame: CGRect(x: (screenwidth/2) - 80, y: -12, width: 100, height: 80))
        logo.image = #imageLiteral(resourceName: "logo")
        logo.contentMode = .scaleAspectFit

        cardBGView.addSubview(logo)

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
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    // MARK: - GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        googleSignInButton.isHidden = error == nil
        // A nil error indicates a successful login
        if (error == nil) {
            // Perform operations on signed in user here
//            let googleUserID = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            UserDefaults.standard.set(user.profile.name, forKey: "fullName")
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
            UserDefaults.standard.set(user.profile.name, forKey: "email")

            // Checks if user has available profile image, if so sets it to userDefaults to be retrieved later when needed
            let hasImage = user.profile.hasImage
            if hasImage {
                let profileImageURL = user.profile.imageURL(withDimension: 400)
                UserDefaults.standard.set(profileImageURL, forKey: "profileImageURL")
            }
//            print("This is googleUserID : \(googleUserID)")
//            print("This is idToken : \(idToken)")
//            print("This is fullName : \(fullName)")
//            print("This is givenName : \(givenName)")
//            print("This is familyName : \(familyName)")
//            print("This is email : \(email)")
//            // TEST PUT function
//            userController.updateUser(id: 1, username: "TestiOS_Two", auth_id: "919178856834", role: "user", created_at: getStringDate()) { (error) in
//                if error != nil {
//                    fatalError("Could not update user")
//                }
//            }

            // Make Get based on userID, if 404 response call create user method then log in as new user
            let defaults = UserDefaults.standard
            guard let userIDFromDefaults = defaults.string(forKey: "ID") else {
                // if no user ID found we need to create a new user
                let randomPassword = String().generateRandomString(length: 10)
                let randomNumberString = String().generateRandomNumberString(length: 3)
                let randomUserName = user.profile.givenName+user.profile.familyName+randomNumberString
                defaults.set(randomUserName, forKey: "username")
                defaults.set(randomPassword, forKey: "password")
                defaults.set(user.profile.givenName, forKey: "firstName")
                userController.createUser(username: randomUserName, password: randomPassword) { (error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.switchView()
                        }
                        return
                    }
                    fatalError("Could not create new user on first google sign-in attempt")
                }
                return
            }
            userController.fetchUser(id: userIDFromDefaults) { (error) in
                    print("first line")
                if error == nil {
                    // if fetch returns successful switchView to logged in home page
                    DispatchQueue.main.async {
                        self.switchView()
                    }
                    return
                }
                fatalError("User defaults has a userID set but fetchUser could not retrieve user from server. Check to see if user exist on server at specified ID")
            }
        } else {

            print("\(error.localizedDescription)")
            print("google sign-in failed")

        }
//        self.switchView()
        googleSignInButton.isHidden = error == nil
    }
    
    func switchView() {
            self.navigationController?.navigationBar.isHidden = true
            let homeTabBar = HomeTabBarController()
            navigationController?.pushViewController(homeTabBar, animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Make user re-sign in or reload Home Tab Controller
    }
    
}



