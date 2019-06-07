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
    
    var loginStatus: Bool = false {
        didSet{
            switchView()
        }
    }

    let signInStackView: UIStackView = {
        let stackView = UIStackView()
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
        
    }
    
    func setupView(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(signInStackView)
        signInStackView.backgroundColor = .lightGray
        signInStackView.axis = .vertical
        signInStackView.frame = CGRect(x: view.frame.width/2, y: view.frame.height/2, width: 200, height: 100)
        signInStackView.distribution = .equalSpacing
        signInStackView.spacing = 20
        signInStackView.centerInSuperview()
        
        if #available(iOS 13.0, *) {
            let authorizationButton = ASAuthorizationAppleIDButton()
            authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
            signInStackView.addArrangedSubview(authorizationButton)
        } else {
            // Fallback on earlier versions
        }
        signInStackView.addArrangedSubview(googleSignInButton)
        googleSignInButton.backgroundColor = #colorLiteral(red: 0.1415234357, green: 0.5382769704, blue: 1, alpha: 1)
        googleSignInButton.frame = CGRect(x: 0, y: 50, width: 200, height: 44)
        googleSignInButton.setTitle("Google Sign In", for: .normal)
        googleSignInButton.addTarget(self, action: #selector(onGoogleSignInButtonTap), for: .touchUpInside)
    }
    
    
    @available(iOS 13.0, *)
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
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

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        print(appleIDCredential.user, appleIDCredential.fullName!, appleIDCredential.email!)
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
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
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
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
