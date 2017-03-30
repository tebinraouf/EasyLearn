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
        label.isHidden = false
        //tv.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var wordDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "View - top,bottom,leading,trailing,fixed height,horizontally center in container (If want "
        label.font = UIFont.systemFont(ofSize: 30)
        label.isHidden = true
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func setupView() {
        
        addSubview(wordName)
        addSubview(wordDetails)
        
        wordName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wordName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        wordDetails.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordDetails.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        wordDetails.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(slideFlashcardHandler))
        addGestureRecognizer(tap)
        
    }
    
    var handleSlideFlipping: (() -> ())?
    func slideFlashcardHandler(){
        handleSlideFlipping?()
    }
    
    
}
