//
//  DetailsCell.swift
//  EasyLearn
//
//  Created by Tebeen on 3/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit
import SwiftIconFont

protocol DetailCellDelegate {
    func handleBookmarkTap()
}

class DetailsCell: BaseCell {
    
    var delegate: WordDetailsVC!
    var didTapBookmark: (() -> ()) = { _ in}
    var didTapMoreCell: (()->()) = { _ in}
    
    var textView: UITextView = {
        let tv = UITextView()
        tv.text = "Testing...."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.isEditable = false
        tv.isSelectable = true
        return tv
    }()
    var containerView: UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        return tv
    }()
    var btnBookmark: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 25)
        btn.setTitle(String.fontAwesomeIcon("bookmark-o"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .appRedish
        btn.backgroundColor = .clear
        return btn
    }()
    var btnMoreDetails: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .MaterialIcon, ofSize: 27)
        btn.setTitle(String.fontMaterialIcon("more.horiz"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .appRedish
        btn.backgroundColor = .white
        return btn
    }()
    var numberCircle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "1"
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.textColor = .appRedish
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func setupView() {
        addSubViews()
        setupContainerView()
        setupTextView()
        setupBtnBookmark()
        setupNumberCircle()
        setupBtnMoreDetails()
    }
    func addSubViews(){
        addSubview(containerView)
        addSubview(textView)
        addSubview(btnBookmark)
        addSubview(numberCircle)
        addSubview(btnMoreDetails)
    }
    func setupContainerView(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: btnBookmark.trailingAnchor, constant: 0)
            ])
    }
    func setupTextView(){
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            textView.bottomAnchor.constraint(equalTo: btnMoreDetails.topAnchor),
            textView.trailingAnchor.constraint(equalTo: btnBookmark.trailingAnchor, constant: -45)
            ])
    }
    func setupBtnBookmark() {
        NSLayoutConstraint.activate([
            btnBookmark.topAnchor.constraint(equalTo: topAnchor, constant: -9),
            btnBookmark.trailingAnchor.constraint(equalTo: trailingAnchor),
            btnBookmark.heightAnchor.constraint(equalToConstant: 40),
            btnBookmark.widthAnchor.constraint(equalToConstant: 40)
            ])
        btnBookmark.addTarget(self, action: #selector(handleBookmarkTap), for: .touchDown)
    }
    func setupNumberCircle() {
        NSLayoutConstraint.activate([
            numberCircle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            numberCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            numberCircle.heightAnchor.constraint(equalToConstant: 20),
            numberCircle.widthAnchor.constraint(equalToConstant: 20)
            ])
    }
    func setupBtnMoreDetails(){
        NSLayoutConstraint.activate([
            btnMoreDetails.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            btnMoreDetails.bottomAnchor.constraint(equalTo: bottomAnchor),
            btnMoreDetails.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnMoreDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
            btnMoreDetails.heightAnchor.constraint(equalToConstant: 20)
            ])
        btnMoreDetails.addTarget(self, action: #selector(handleSubWordDetails), for: .touchDown)
    }
    func handleBookmarkTap(){
        didTapBookmark()
    }
    func handleSubWordDetails(){
        didTapMoreCell()
    }
}



extension DetailsCell {
    public var textViewText: NSAttributedString? {
        get {
            return textView.attributedText
        }
        set {
            textView.attributedText = newValue
        }
    }
    public var cellNumberText: String? {
        get {
            return numberCircle.text
        }
        set {
            numberCircle.text = newValue
        }
    }
    public var bookmarkIconText: String? {
        get {
            return btnBookmark.titleLabel?.text
        }
        set {
            btnBookmark.setTitle(newValue, for: .normal)
        }
    }
    public var isMore: Bool {
        get {
            return btnMoreDetails.isHidden
        }
        set {
            btnMoreDetails.isHidden = newValue
        }
    }
}






