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
    var indexPath: IndexPath!
    
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
    var bookmarkLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    var bookmarkLabel: UILabel = {
        //put an icon as an image here.
        let label = UILabel()
        label.font = UIFont.icon(from: .FontAwesome, ofSize: 25)
        label.text = String.fontAwesomeIcon("bookmark-o")
        label.textColor = .appRedish
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(containerView)
        addSubview(textView)
        addSubview(bookmarkLabelView)
        addSubview(numberCircle)
        addSubview(btnMoreDetails)
        bookmarkLabelView.addSubview(bookmarkLabel)
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: bookmarkLabelView.trailingAnchor, constant: 0).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        textView.bottomAnchor.constraint(equalTo: btnMoreDetails.topAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: bookmarkLabelView.trailingAnchor, constant: -45).isActive = true
        
        bookmarkLabelView.topAnchor.constraint(equalTo: topAnchor, constant: -9).isActive = true
        bookmarkLabelView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bookmarkLabelView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookmarkLabelView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bookmarkLabel.topAnchor.constraint(equalTo: bookmarkLabelView.topAnchor).isActive = true
        bookmarkLabel.bottomAnchor.constraint(equalTo: bookmarkLabelView.bottomAnchor).isActive = true
        bookmarkLabel.leadingAnchor.constraint(equalTo: bookmarkLabelView.leadingAnchor).isActive = true
        bookmarkLabel.trailingAnchor.constraint(equalTo: bookmarkLabelView.trailingAnchor).isActive = true
        
        numberCircle.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        numberCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        numberCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numberCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBookmarkTap))
        bookmarkLabelView.addGestureRecognizer(tap)
        
        btnMoreDetails.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
        btnMoreDetails.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        btnMoreDetails.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        btnMoreDetails.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        btnMoreDetails.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        btnMoreDetails.addTarget(self, action: #selector(handleSubWordDetails), for: .touchDown)
        
        
    }
    var completion: (() -> ())?
    func handleBookmarkTap(){
        completion?()
    }
    var handleSubWordCompletion: (()->())?
    func handleSubWordDetails(){
        handleSubWordCompletion?()
    }
    
    
    func displayWordInCell(using detailsViewModel: DetailsViewModel) {
        textView.attributedText = detailsViewModel.textView
        numberCircle.text = detailsViewModel.numberCircle
        bookmarkLabel.text = detailsViewModel.bookmarkLabel
    }
    
}
