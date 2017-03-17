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
    
    var delegate: WordDetailsViewController!
    
    
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
    var circleView: UIView = {
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
    var numberCircle: UILabel = {
        //put an icon as an image here.
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
        addSubview(circleView)
        addSubview(numberCircle)
        circleView.addSubview(bookmarkLabel)
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 0).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: -45).isActive = true
        
        circleView.topAnchor.constraint(equalTo: topAnchor, constant: -9).isActive = true
        circleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bookmarkLabel.topAnchor.constraint(equalTo: circleView.topAnchor).isActive = true
        bookmarkLabel.bottomAnchor.constraint(equalTo: circleView.bottomAnchor).isActive = true
        bookmarkLabel.leadingAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        bookmarkLabel.trailingAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        
        numberCircle.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        numberCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        numberCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numberCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBookmarkTap))
        circleView.addGestureRecognizer(tap)
        
    }
    var completion: (() -> ())?
    func handleBookmarkTap(){
        completion?()
    }
    
}
