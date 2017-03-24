//
//  wordDetailsSetupViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/23/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension WordDetailsVC  {
    
    func setupView(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
 
}
