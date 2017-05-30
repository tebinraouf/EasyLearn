//
//  Menu.swift
//  EasyLearn
//
//  Created by Tebeen on 5/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import FBSDKLoginKit


struct MenuAction {
    var menu: MenuSelector
    var navigationController: UINavigationController?
    var homeController: HomeViewController?
    
    init(_ menu: MenuSelector) {
        self.menu = menu
    }
    func setMenuAction(){
        switch menu {
        case .account:
            handleAccount()
        case .logout:
            handleLogout()
        case .purchase:
            handlePurchase()
        case .feedback:
            handleFeedback()
        }
    }
}
extension MenuAction: MenuActionable {
    func handleAccount() {
        print("account")
    }
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { (action) in
            isLoggedIn = false
            self.navigationController?.pushViewController(PageController(), animated: true)
            FBSDKLoginManager().logOut()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.homeController?.present(alert, animated: true)
    }
    func handlePurchase() {
        print("purchase")
    }
    func handleFeedback() {
        print("feedback")
    }
}

protocol MenuActionable {
    func handleAccount()
    func handleLogout()
    func handlePurchase()
    func handleFeedback()
}
enum MenuSelector: Int {
    case account
    case logout
    case purchase
    case feedback
}
