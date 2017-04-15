//
//  FlashCardCell.swift
//  EasyLearn
//
//  Created by Tebeen on 3/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class FlashCardCell: BaseCell {
    
    let flashCardView = FlashCardView()
    
    override func setupView() {
        backgroundColor = .clear
        addSubview(flashCardView)
        NSLayoutConstraint.activate([
            flashCardView.topAnchor.constraint(equalTo: topAnchor),
            flashCardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            flashCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            flashCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    let tap = UITapGestureRecognizer(target: self, action: #selector(slideFlashcardHandler))
        addGestureRecognizer(tap)
        
        let isCardNumberLabelHidden = UserDefaults.standard.bool(forKey: UserDefaultsKeys.cardNumberLabel.rawValue)
        if !isCardNumberLabelHidden {
            flashCardView.cardNumber.isHidden = true
        } else {
            flashCardView.cardNumber.isHidden = false
        }
    }
    
    var handleSlideFlipping: (() -> ())?
    func slideFlashcardHandler(){
        handleSlideFlipping?()
    }
    
    
}

//This is to round any view corner (per corner)
class RoundedLabelView: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = shapeLayer
        
    }
}
