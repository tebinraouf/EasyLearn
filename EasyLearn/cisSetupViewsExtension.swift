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
        selectorView.wordNameBgColor = colorCells.saveSampleCardProperties()[0]
        selectorView.wordDetailsBgColor = colorCells.saveSampleCardProperties()[0]
        
        selectorView.wordNameTextColor = colorCells.saveSampleCardProperties()[1]
        selectorView.wordDetailsTextColor = colorCells.saveSampleCardProperties()[1]
        selectorView.cardNumberTextColor = colorCells.saveSampleCardProperties()[1]
        
        selectorView.viewBgColor = colorCells.saveSampleCardProperties()[2]

    }
    
    
}
