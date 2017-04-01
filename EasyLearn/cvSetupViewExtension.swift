//
//  cvSetupViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/25/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardsViewController {
    func setupView(){
        cardView.flashCV.delegate = self
        cardView.flashCV.dataSource = self

        view.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
}
