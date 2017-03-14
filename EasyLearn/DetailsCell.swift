//
//  DetailsCell.swift
//  EasyLearn
//
//  Created by Tebeen on 3/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class DetailsCell: BaseCell {
    
    var textView: UITextView = {
        let tv = UITextView()
        tv.text = "Testing...."
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .cyan
        return tv
    }()
    var circle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = .brown
        return view
    }()
    
    
    override func setupView() {
        
        addSubview(textView)
        addSubview(circle)
        
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: circle.trailingAnchor, constant: -45).isActive = true
        
        circle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        circle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
}
