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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "testing..."
        label.font = UIFont.systemFont(ofSize: 30)
        //tv.isEditable = false
        
        //tv.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
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
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isEditable = false
        //label.numberOfLines = 0
        return label
    }()
    
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func setupView() {
        
        backgroundColor = .clear
        addSubview(wordName)
        addSubview(wordDetails)
        
        
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
        
        
    let tap = UITapGestureRecognizer(target: self, action: #selector(slideFlashcardHandler))
        addGestureRecognizer(tap)
        
    }
    
    var handleSlideFlipping: (() -> ())?
    func slideFlashcardHandler(){
        handleSlideFlipping?()
    }
    
    
}
