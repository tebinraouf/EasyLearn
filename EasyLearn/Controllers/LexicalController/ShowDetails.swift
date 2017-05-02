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
        
        let webService = WebService((word?.word!)!, selectedWord, filters: [.examples, .definitions, .registers, .pronunciations])
        
        webService.get(details:  { (details, status) in
            
            word?.details = details
            word?.lexicalEntry = selectedWord
            
            let detailsViewController = WordDetailsVC()
            detailsViewController.word = word
            
            let navController = UINavigationController(rootViewController: detailsViewController)
            
            detailsViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelPresentViewController))
            
            self.controller.present(navController, animated: true, completion: nil)
        })
 
    }
    @objc func cancelPresentViewController(){
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}