//
//  SelectorViewModel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class SelectorViewModel {
    var selectorView: ColorImageSelectorView
    var colorModel = ColorCellsViewModel()

    init(selectorView: ColorImageSelectorView) {
        self.selectorView = selectorView
    }
    
    func changeColors(_ row: IndexPath, _ item: IndexPath) {
        
        switch row.item {
        case 0:
            //Card Background - Text Background (wordName & wordDetails) Property 01
            selectorView.wordNameBgColor = colorModel.backgroundColorForItemAt(item)
            selectorView.wordDetailsBgColor = colorModel.backgroundColorForItemAt(item)
        case 1:
            //Text Color (The text's color) Property 02
            selectorView.wordNameTextColor = colorModel.backgroundColorForItemAt(item)
            selectorView.wordDetailsTextColor = colorModel.backgroundColorForItemAt(item)
        case 2:
            //View Background Property 03
            selectorView.viewBgColor = colorModel.backgroundColorForItemAt(item)
        default:
            break
        }
        
    }
    
}
