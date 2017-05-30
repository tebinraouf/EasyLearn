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
        guard let email = pageView.loginEmail else { return }
        guard let password = pageView.loginPassword else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            self.handling(error)
            guard let authEmail = user?.email else { return }
            let newUser = User(name: authEmail, email: authEmail)
            let userLayer = UserCoreDataLayer()
            userLayer.add(newUser)
            DispatchQueue.main.async {
                isLoggedIn = true
                self.handleGetStarted()
            }
        })
    }
    func registerBtn() {
        //TODO:- Pass the name to Firebase
        guard let name = pageView.loginName else { return }
        guard let email = pageView.loginEmail else { return }
        guard let password = pageView.loginPassword else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            self.handling(error)
            guard let authEmail = user?.email else { return }
            let newUser = User(name: name, email: authEmail)
            let userLayer = UserCoreDataLayer()
            userLayer.add(newUser)
            DispatchQueue.main.async {
                isLoggedIn = true
                self.handleGetStarted()
            }
        })
    }
    func forgetPasswordBtn() {
        let requestAlert = UIAlertController(title: "Request Password", message: nil, preferredStyle: .alert)
        requestAlert.addTextField { (textfield) in
            textfield.keyboardType = .emailAddress
            textfield.placeholder = "enter your email here..."
        }
        requestAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        requestAlert.addAction(UIAlertAction(title: "Request New Password", style: .default) { (action) in
            //action.title = "Sent..."
            guard let requestedEmail = requestAlert.textFields?.first?.text else { return }
            FIRAuth.auth()?.sendPasswordReset(withEmail: requestedEmail) { (error) in
                self.handling(error)
                alert(title: "Sent", message: "Check your email to set your new password.", viewController: self)
            }
        })
        self.present(requestAlert, animated: true)
    }
    func getStartedBtn() {
        let indexPath = IndexPath(item: 3, section: 0)
        pageView.pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
    }
    func handling(_ error: Error?){
        if error != nil {
            print("The error is: ", error ?? "")
            if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                switch errCode {
                case .errorCodeEmailAlreadyInUse:
                    alert(title: "Email", message: (error?.localizedDescription)!, viewController: self)
                case .errorCodeInvalidEmail:
                    alert(title: "Email", message: (error?.localizedDescription)!, viewController: self)
                case .errorCodeWeakPassword:
                    alert(title: "Password", message: (error?.localizedDescription)!, viewController: self)
                case .errorCodeInternalError:
                    alert(title: "Missing Email", message: "Please provide an email address.", viewController: self)
                default:
                    alert(title: "Oops...", message: (error?.localizedDescription)!, viewController: self)
                }
            }
            return
        }
    }
}
