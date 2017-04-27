//
//  cisSetupViews.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension ColorImageSelector {
    func setupViews(){
        selectorViewSetup()
        handleClickableViews()
        selectedColorsForSampleCard()
    }
    func selectorViewSetup(){
        view.addSubview(selectorView)
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            selectorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func handleClickableViews(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSampleCardFlipping))
        selectorView.labelViews.addGestureRecognizer(tap)
    }
    func handleSampleCardFlipping(){
        handleFlipping(from: selectorView.labelViews.wordName, to: selectorView.labelViews.wordDetails, isFlipped: &isFlipped)
    }
    
    func selectedColorsForSampleCard(){
        let colorCells = ColorCellsViewModel()
        
        if let backgroundColor = colorCells.saveSampleCardProperties()?.first {
            selectorView.wordNameBgColor = backgroundColor
            selectorView.wordDetailsBgColor = backgroundColor
        }
        
        if let textColor = colorCells.saveSampleCardProperties()?[1] {
            selectorView.wordNameTextColor = textColor
            selectorView.wordDetailsTextColor = textColor
            selectorView.cardNumberTextColor = textColor
        }
        
        if let viewColor = colorCells.saveSampleCardProperties()?[2] {
            selectorView.viewBgColor = viewColor
        }
        

    }
    
    
}
