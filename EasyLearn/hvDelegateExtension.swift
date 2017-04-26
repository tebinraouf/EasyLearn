//
//  HomeViewControllerExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController {
    //MARK:- Handle Search
    func handleSearch(){
        homeViewAction.handleSearch()
    }
    func handleMoreButton() {
        homeViewAction.handleMoreButton()
    }
    func handleMenuSlide() {
        homeViewAction.handleMenuSlide()
    }
    func handleMenuSlideLeft(gesture: UIScreenEdgePanGestureRecognizer){
        homeViewAction.handleMenuSlideLeft(gesture: gesture)
    }
}
