//
//  FlashCardView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class FlashCardView: UIView {
    
    let wordName: UILabel = {
        let image = UIImage(named: "")
        let iv = UIImageView(image: image)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Sample"
        label.font = UIFont.systemFont(ofSize: 30)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let wordDetails: VerticallyCenteredTextView = {
        let label = VerticallyCenteredTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "A small part or quantity intended to show what the whole is like."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.isEditable = false
        return label
    }()
    let cardNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "# - #"
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = UIColor(r: 220, g: 220, b: 221, a: 0.2)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    func setupView() {
        backgroundColor = .clear
        addSubview(wordName)
        addSubview(wordDetails)
        addSubview(cardNumber)
        
        wordName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wordName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        wordName.isHidden = false
        
        wordDetails.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wordDetails.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wordDetails.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wordDetails.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        wordDetails.isHidden = true
        
        cardNumber.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardNumber.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cardNumber.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
