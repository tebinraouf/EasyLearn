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
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.setupView()
        view.addSubview(homeView)
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSearch))
        homeView.searchButtonView.addGestureRecognizer(tap)
        
    }
}
