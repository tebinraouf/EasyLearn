//
//  SetupViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func setupView(){
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        homeView.searchTextField.delegate = self

        view.addSubview(homeView)
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        homeView.searchButton.addTarget(self, action: #selector(handleSearch), for: .touchDown)
        homeView.moreButton.addTarget(self, action: #selector(handleMoreButton), for: .touchDown)
        
        handleGestures()
    }
    
    
    func handleGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenuSlide))
        homeView.containerView.addGestureRecognizer(tap)
        
        let swipeTap = UISwipeGestureRecognizer(target: self, action: #selector(handleMenuSlide))
        swipeTap.direction = UISwipeGestureRecognizerDirection.left
        homeView.collectionViewSlider.addGestureRecognizer(swipeTap)
        
        let leftEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleMenuSlideLeft(gesture:)))
        leftEdgePanGesture.edges = .left
        homeView.addGestureRecognizer(leftEdgePanGesture)
    }
}
