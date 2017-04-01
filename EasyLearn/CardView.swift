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
        layout.minimumInteritemSpacing = 10000.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .blue
        cv.isPagingEnabled = true
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 - 10"
        label.textColor = .black
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
    
    var toolBar: UIToolbar = {
        let tool = UIToolbar()
        tool.translatesAutoresizingMaskIntoConstraints = false
        return tool
    }()
    
    var navBar: UIToolbar = {
        let tool = UIToolbar()
        tool.translatesAutoresizingMaskIntoConstraints = false
        return tool
    }()
    
    
    var flashCVTopConstraint: NSLayoutConstraint?
    var flashCVBottomConstraint: NSLayoutConstraint?
    var flashCVLeadingConstraint: NSLayoutConstraint?
    var flashCVTrailingConstraint: NSLayoutConstraint?
    
    
    var flashCVHeightConstraint: NSLayoutConstraint!
    
    
    var cardNumberLabelBottomConstraint: NSLayoutConstraint?
    var checkButtonBottomConstraint: NSLayoutConstraint?
    
    
    var toolBarBottomConstraint: NSLayoutConstraint!
    
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
        flashCVTopConstraint?.isActive = false
        
        flashCVBottomConstraint = flashCV.bottomAnchor.constraint(equalTo: cardNumberLabel.topAnchor, constant: -10)
        flashCVBottomConstraint?.isActive = false
        
        flashCVLeadingConstraint = flashCV.leadingAnchor.constraint(equalTo: leadingAnchor)
        flashCVLeadingConstraint?.isActive = true
        
        flashCVTrailingConstraint = flashCV.trailingAnchor.constraint(equalTo: trailingAnchor)
        flashCVTrailingConstraint?.isActive = true
        
        
        flashCVHeightConstraint = flashCV.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3)
        flashCVHeightConstraint.isActive = true
        
        flashCV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        flashCV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
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
        
         
        addSubview(toolBar)
        toolBarBottomConstraint = toolBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        toolBarBottomConstraint.isActive = true
        toolBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        addSubview(navBar)
        navBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
