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
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        return cv
    }()
    var checkButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("check"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.cgColor
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
    var flashCVTopConstraint: NSLayoutConstraint?
    var flashCVBottomConstraint: NSLayoutConstraint?
    var flashCVLeadingConstraint: NSLayoutConstraint?
    var flashCVTrailingConstraint: NSLayoutConstraint?
    var flashCVHeightConstraint: NSLayoutConstraint!
    var toolBarBottomConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func setupView() {
        addSubview(flashCV)
        flashCVTopConstraint = flashCV.topAnchor.constraint(equalTo: topAnchor, constant: 80)
        flashCVTopConstraint?.isActive = false
        flashCVBottomConstraint = flashCV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        flashCVBottomConstraint?.isActive = false
        flashCVLeadingConstraint = flashCV.leadingAnchor.constraint(equalTo: leadingAnchor)
        flashCVLeadingConstraint?.isActive = true
        flashCVTrailingConstraint = flashCV.trailingAnchor.constraint(equalTo: trailingAnchor)
        flashCVTrailingConstraint?.isActive = true
        flashCVHeightConstraint = flashCV.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3)
        flashCVHeightConstraint.isActive = true
        flashCV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        flashCV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(toolBar)
        toolBarBottomConstraint = toolBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        toolBarBottomConstraint.isActive = true
        toolBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
