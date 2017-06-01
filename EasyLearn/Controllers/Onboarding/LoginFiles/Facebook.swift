//
//  Facebook.swift
//  EasyLearn
//
//  Created by Tebeen on 5/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import Firebase

//MARK:- Facebook Login Button Delegate
extension PageController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(grantedPermissions: let granted, declinedPermissions: _, token: let token):
            if granted.contains(Permission(name: "email")) {
                saveUserBy(access: token) { (email) in
                //guard let email = email else { return }
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        self.handleGetStarted()
                    }
                }
            } else {
                alert(title: "Email Address", message: "Please grant us your email address to create your account.", viewController: self)
                FBSDKLoginManager().logOut()
            }
        case .cancelled:
            print("User cancelled login.")
        case .failed(let error):
            print(error)
        }
    }
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logout")
    }
    func saveUserBy(access token: AccessToken, callBack: @escaping (String?)->()) {
        let token = token.authenticationToken
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            callBack(user?.email)
        }
    }
}
