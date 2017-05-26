//
//  CustomLogin.swift
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
import FirebaseAuth


extension PageController: LoginViewDelegate {
    
    func loginBtn() {
        print("Login btn")
        guard let email = pageView.loginEmail else { return }
        guard let password = pageView.loginPassword else { return }
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("The error is: ",error ?? "")
                return
            }
            
            guard let authName = user?.displayName else { return }
            guard let authEmail = user?.email else { return }
            
            let userObject = User(name: authName, email: authEmail)
            
            //print("Successfully login....", user?.displayName)
        })
        
        
        
    }
    func registerBtn() {
        
        //pageView.loginName
        //pageView.loginEmail
        //pageView.loginPassword
        //TODO:- Pass the name to Firebase
        guard let name = pageView.loginName else { return }
        guard let email = pageView.loginEmail else { return }
        guard let password = pageView.loginPassword else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("The error is: ",error ?? "")
                return
            }
            //print(user)
            print("User is registered")
        })
    }
    func forgetPasswordBtn() {
        print("password btn")
    }
    func getStartedBtn() {
        let indexPath = IndexPath(item: 3, section: 0)
        pageView.pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
    }
}
