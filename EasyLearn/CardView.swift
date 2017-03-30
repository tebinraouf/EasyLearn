//
//  CardView.swift
//  EasyLearn
//
//  Created by Tebeen on 3/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardView: UIView {
    var flashCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 - 10"
        label.textColor = .yellow
        return label
    }()
    
    var checkButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("check"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.lightGray.cgColor
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .gray
        return btn
    }()
    
    var flashCVTopConstraint: NSLayoutConstraint?
    var flashCVBottomConstraint: NSLayoutConstraint?
    var cardNumberLabelBottomConstraint: NSLayoutConstraint?
    var checkButtonBottomConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    func setupView(){
        
        addSubview(flashCV)
        addSubview(cardNumberLabel)
        addSubview(checkButton)
        
        flashCVTopConstraint = flashCV.topAnchor.constraint(equalTo: topAnchor, constant: 80)
        flashCVTopConstraint?.isActive = true
        
        flashCVBottomConstraint = flashCV.bottomAnchor.constraint(equalTo: cardNumberLabel.topAnchor, constant: -10)
        flashCVBottomConstraint?.isActive = true
        
        flashCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        flashCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        cardNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        cardNumberLabel.topAnchor.constraint(equalTo: flashCV.bottomAnchor).isActive = true
        cardNumberLabelBottomConstraint = cardNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
        cardNumberLabelBottomConstraint?.isActive = true
        cardNumberLabel.heightAnchor.constraint(equalTo: cardNumberLabel.heightAnchor).isActive = true
        cardNumberLabel.widthAnchor.constraint(equalTo: cardNumberLabel.widthAnchor).isActive = true
        
        
        checkButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        checkButton.topAnchor.constraint(equalTo: flashCV.bottomAnchor, constant: 10).isActive = true
        checkButtonBottomConstraint = cardNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
        checkButtonBottomConstraint?.isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
