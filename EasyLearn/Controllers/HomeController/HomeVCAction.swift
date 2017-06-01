//
//  HomeVCAction.swift
//  EasyLearn
//
//  Created by Tebeen on 4/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension HomeViewController: HomeViewDelegate {
    
    //MARK:- Handle Search
    func handleSearch(){
        if let text = homeView.searchText {
            if text.isEmpty {
                homeView.searchPlaceHolder = "Please type a word"
            }else {
                homeView.searchPlaceHolder = "Search..."
                if Reachability.isConnectedToNetwork {
                    //MARK:- Free Word Search
                    if searchLimitCount > 0 {
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
                        searchLimitCount -= 1
                        self.ref.child("users").child(userID).setValue(["searchLimit": searchLimitCount])
                        //end of web service
                    } else {
                        //MARK:- Ask User to Purchase
                        print("You gorra unlock the unlimited feature...bro...")
                    }
                } else {
                    noInternetAlert(self)
                }
            }
        }
    }
    //MARK:- TopContainerSlider
    func handleMoreButton() {
        
        //handleConstant(constant: 0)
        print("more is clicked....")
        animateSettingFor(value: 100, sliderOpacity: 1)
    }
    func handleTapTopContainer() {
        print("tappppppp")
        animateSettingFor(value: 0, sliderOpacity: 0)
    }
    
    
    func handleMenuSlide() {
        //handleConstant(constant: -200)
    }
    func handleCard() {
        navigationController?.pushViewController(CardsViewController(), animated: true)
    }
    func handleMoreCategory() {
        navigationController?.pushViewController(DomainController(), animated: true)
    }
    
    //    func handleMenuSlideLeft(gesture: UIScreenEdgePanGestureRecognizer){
    //        switch gesture.state {
    //        case .began, .changed:
    //            handleConstant(constant: 0)
    //        default: break
    //        }
    //    }
    //    private func handleConstant(constant: CGFloat){
    //        self.homeView.collectionVSLeadingAnchor?.constant = constant
    //        UIView.animate(withDuration: 0.3) {
    //            self.view.layoutIfNeeded()
    //        }
    //    }
    private func goToErrorEmptyViewControllerWith(text: String){
        let errorEmptyViewController = ErrorEmptyViewController()
        errorEmptyViewController.messageLabel.text = text
        push(errorEmptyViewController)
    }
    private func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    func animateSettingFor(value constant: CGFloat, sliderOpacity: Float){
        homeView.topContainerConstant = constant
        self.homeView.collectionViewSliderOpacity = sliderOpacity
        //self.homeView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) //super cool
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
}

