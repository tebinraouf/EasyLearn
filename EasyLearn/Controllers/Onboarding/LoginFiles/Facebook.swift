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
import FirebaseAuth


//Facebook Login Button Delegate

extension PageController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        switch result {
        case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
            
            let request = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])
            request?.start { (_, _, error) in
                //first parameter: connection, result, error
                if error != nil {
                    print("The error is: ",error ?? "")
                    return
                }
                
                let access = accessToken.authenticationToken
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: access)
                
                
                
                FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    
                    print("Successfully logged in: ",user)
                })
                //print(result)
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
}
