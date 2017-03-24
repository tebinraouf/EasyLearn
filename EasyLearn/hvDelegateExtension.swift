//
//  HomeViewControllerExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController: HomeViewDelegate {
    //MARK:- Handle Search
    func handleSearch(){
        if let text = homeView.searchTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
            
            if text.isEmpty {
                homeView.searchTextField.placeholder = "Please type a word"
            }else {
                homeView.searchTextField.placeholder = "Search..."
                Service.sharedInstance.initialSearch(word: text, completion: { (word, error) in
                    self.handleNextViewController(word, error)
                })
            }
            
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
        errorEmptyViewController.delegate = self
        errorEmptyViewController.messageLabel.text = text
        self.navigationController?.pushViewController(errorEmptyViewController, animated: true)
    }
    
    func handleMoreButton() {
        handleConstant(constant: 0)
    }
    func handleMenuSlide() {
        handleConstant(constant: -200)
    }
    func handleMenuSlideLeft(gesture: UIScreenEdgePanGestureRecognizer){
        switch gesture.state {
        case .began, .changed:
            handleConstant(constant: 0)
        default: break
        }
    }
    
    func handleConstant(constant: CGFloat){
        self.homeView.collectionVSLeadingAnchor?.constant = constant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
