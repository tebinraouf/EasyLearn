//
//  App.swift
//  EasyLearn
//
//  Created by Tebeen on 4/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class App {
    
    var navigationController: UINavigationController
    
    init(_ window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        navigationController = window.rootViewController as! UINavigationController
        let homeViewController = navigationController.viewControllers[0] as! HomeViewController
        homeViewController.didSelectNextViewController = showController
        homeViewController.getNextViewController = handleNextViewController
    }
    private func showController(_ indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            push(CardsViewController())
        case 1:
            push(CustomCardsViewController())
        case 2:
            push(PlayViewController())
        case 3:
            push(SettingsViewController())
        default: break
        }
    }
    private func handleNextViewController(_ word: Word?, _ error: Error?) {
        if error == nil && word?.id != nil {
            let lexicalEntryVC = LexicalEntryViewController()
            lexicalEntryVC.word = word
            push(lexicalEntryVC)
        } else if word?.id == nil && error == nil {
            goToErrorEmptyViewControllerWith(text: "No result. Please try another word.")
        } else {
            goToErrorEmptyViewControllerWith(text: "The Internet connection appears to be offline.")
        }
    }
    private func goToErrorEmptyViewControllerWith(text: String){
        let errorEmptyViewController = ErrorEmptyViewController()
        errorEmptyViewController.messageLabel.text = text
        push(errorEmptyViewController)
    }
    private func push(_ controller: UIViewController) {
        navigationController.pushViewController(controller, animated: true)
    }
}
