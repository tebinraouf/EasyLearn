//
//  HomeVCAction.swift
//  EasyLearn
//
//  Created by Tebeen on 4/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class HomeVCAction: HomeViewDelegate {
    
    var homeView: HomeView!
    var delegate: HomeViewController!
    var view: UIView!
    var navigationController: UINavigationController?
    var pushToNextViewController: (Word?, Status) -> () = { _ in }
    
    //MARK:- Handle Search
    func handleSearch(){
        if let text = homeView.searchText {
            if text.isEmpty {
                homeView.searchPlaceHolder = "Please type a word"
            }else {
                homeView.searchPlaceHolder = "Search..."
                
                
                if Reachability.isConnectedToNetwork {
                    let webService = WebService(text, filters: [.lexicalCategory])
                    
                    webService.get({ (word, status) in
                        //self.pushToNextViewController(word, status)
                        
                        
                        switch status {
                        case .Success:
                            let lexicalEntryVC = LexicalEntryViewController()
                            lexicalEntryVC.word = word
                            self.push(lexicalEntryVC)
                        case .NotFound:
                            self.goToErrorEmptyViewControllerWith(text: "No result. Please try another word.")
                        }
                        
                        
                        
                    })
                    
                    if webService.request != nil {
                        homeView.containerView.isHidden = false
                        homeView.activityIndicatorView.startAnimating()
                    }
                    
                } else {
                    noInternetAlert(delegate)
                }
                
                
            }
        }
    }
    func handleMoreButton() {
        handleConstant(constant: 0)
    }
    func handleMenuSlide() {
        handleConstant(constant: -200)
    }
    func handleCard() {
        navigationController?.pushViewController(CardsViewController(), animated: true)
    }
    func handleMoreCategory() {
        navigationController?.pushViewController(DomainController(), animated: true)
    }
    
    func handleMenuSlideLeft(gesture: UIScreenEdgePanGestureRecognizer){
        switch gesture.state {
        case .began, .changed:
            handleConstant(constant: 0)
        default: break
        }
    }
    private func handleConstant(constant: CGFloat){
        self.homeView.collectionVSLeadingAnchor?.constant = constant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    private func goToErrorEmptyViewControllerWith(text: String){
        let errorEmptyViewController = ErrorEmptyViewController()
        errorEmptyViewController.messageLabel.text = text
        push(errorEmptyViewController)
    }
    private func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
