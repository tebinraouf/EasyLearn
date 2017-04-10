//
//  csSetupViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardSettingsController {
    func setupView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //        collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        //        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        
    }
}
