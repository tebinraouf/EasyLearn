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
        
        view.addSubview(flashCV)
        view.addSubview(cardNumberLabel)
        view.addSubview(checkButton)
        
        flashCVTopConstraint = flashCV.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 80)
        flashCVTopConstraint?.isActive = true
        
        flashCVBottomConstraint = flashCV.bottomAnchor.constraint(equalTo: cardNumberLabel.topAnchor, constant: -10)
        flashCVBottomConstraint?.isActive = true
        
        flashCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        flashCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        cardNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cardNumberLabel.topAnchor.constraint(equalTo: flashCV.bottomAnchor).isActive = true
        cardNumberLabelBottomConstraint = cardNumberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        cardNumberLabelBottomConstraint?.isActive = true
        cardNumberLabel.heightAnchor.constraint(equalTo: cardNumberLabel.heightAnchor).isActive = true
        cardNumberLabel.widthAnchor.constraint(equalTo: cardNumberLabel.widthAnchor).isActive = true
        
        
        checkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        checkButton.topAnchor.constraint(equalTo: flashCV.bottomAnchor, constant: 10).isActive = true
        checkButtonBottomConstraint = cardNumberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        checkButtonBottomConstraint?.isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
    }
}
