//
//  ShowDetails.swift
//  EasyLearn
//
//  Created by Tebeen on 4/27/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ShowDetails {
    var navigationController: UINavigationController?
    var controller: LexicalEntryViewController
    
    init(nav: UINavigationController?) {
        self.navigationController = nav
        controller = navigationController?.topViewController as! LexicalEntryViewController
        controller.didSelect = showWord
    }
    func showWord(word: Word?, selectedWord: String) {
        
        if Reachability.isConnectedToNetwork {
            
            let web = WebService((word?.id)!, selectedWord, filters: [.lexicalCategory, .examples, .definitions, .registers, .pronunciations])
            
            web.get { (word, status) in
                
                word?.lexicalEntry = selectedWord
                
                let detailsViewController = WordDetailsVC()
                detailsViewController.word = word
                
                let navController = UINavigationController(rootViewController: detailsViewController)
                
                detailsViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelPresentViewController))
                
                self.controller.present(navController, animated: true, completion: nil)
            }
            
            if web.request != nil {
                controller.activityIndicatorView.startAnimating()
            }
            
            
        } else {
            noInternetAlert(controller)
        }
        
        
 
    }
    @objc func cancelPresentViewController(){
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
