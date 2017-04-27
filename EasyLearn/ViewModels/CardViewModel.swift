//
//  CardViewModel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardViewModel {
    var cell: FlashCardCell?
    var currentDataLayer = ColorCoreDataLayer()
    var cardView: CardView!
    
    init(_ cell: FlashCardCell, _ cardView: CardView) {
        self.cell = cell
        self.cardView = cardView
    }
    
    func changeCellBackgroundColor() {
        let properties = ["isCardColor","isTextColor","isViewColor"]
        var color: Color!
        
        color = currentDataLayer.getColor(for: properties[0])
        if let red = color?.red, let green = color?.green, let blue = color?.blue, let alpha = color?.alpha {
            cell?.flashCardView.cardColor = UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: CGFloat(alpha))
        }
        color = currentDataLayer.getColor(for: properties[1])
        if let red = color?.red, let green = color?.green, let blue = color?.blue, let alpha = color?.alpha {
            cell?.flashCardView.textColor = UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: CGFloat(alpha))
        }
        color = currentDataLayer.getColor(for: properties[2])
        if let red = color?.red, let green = color?.green, let blue = color?.blue, let alpha = color?.alpha {
            cardView.backgroundColor = UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: CGFloat(alpha))
        }
    }
}
