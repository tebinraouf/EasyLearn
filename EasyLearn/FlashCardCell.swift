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
    
    var wordName: UILabel = {
        let image = UIImage(named: "")
        let iv = UIImageView(image: image)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "testing..."
        label.font = UIFont.systemFont(ofSize: 30)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var wordDetails: VerticallyCenteredTextView = {
        let label = VerticallyCenteredTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "testing"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.isEditable = false
        return label
    }()
    
    var cardNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "100"
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = UIColor(r: 220, g: 220, b: 221, a: 0.2)
        label.textAlignment = .center
        return label
    }()
    
    override func setupView() {
        
        backgroundColor = .clear
        addSubview(wordName)
        addSubview(wordDetails)
        addSubview(cardNumber)
        
        wordName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        wordName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        wordName.isHidden = false
        
        
        wordDetails.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordDetails.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        wordDetails.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        wordDetails.isHidden = true
        
        
        
        cardNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cardNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cardNumber.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardNumber.heightAnchor.constraint(equalTo: cardNumber.heightAnchor).isActive = true
        
        
        
    let tap = UITapGestureRecognizer(target: self, action: #selector(slideFlashcardHandler))
        addGestureRecognizer(tap)
        
    }
    
    var handleSlideFlipping: (() -> ())?
    func slideFlashcardHandler(){
        handleSlideFlipping?()
    }
    
    
}


