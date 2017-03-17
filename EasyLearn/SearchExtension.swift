//
//  HomeViewControllerExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController: HandleSearchDelegate {
    //MARK:- Handle Search
    func handleSearch(){
        if let text = homeView.searchTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
            Service.sharedInstance.initialSearch(word: text, completion: { (word, error) in
                self.handleNextViewController(word, error)
            })
        }
    }
    func handleNextViewController(_ word: Word?, _ error: Error?) {
        if error == nil && word?.id != nil {
            let lexicalEntryVC = LexicalEntryViewController()
            lexicalEntryVC.delegate = self
            lexicalEntryVC.word = word
            self.navigationController?.pushViewController(lexicalEntryVC, animated: true)
        } else if word?.id == nil && error == nil {
            goToErrorEmptyViewControllerWith(text: "No result. Please try another word.")
        } else {
            goToErrorEmptyViewControllerWith(text: "The Internet connection appears to be offline.")
        }
    }
    func goToErrorEmptyViewControllerWith(text: String){
        let errorEmptyViewController = ErrorEmptyViewController()
        errorEmptyViewController.messageLabel.text = text
        self.navigationController?.pushViewController(errorEmptyViewController, animated: true)
    }
}
