//
//  DashboardCell.swift
//  EasyLearn
//
//  Created by Tebeen on 3/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class DashboardCell: BaseCell {
    
    let deckNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        
        //layer.cornerRadius = 20
        //layer.masksToBounds = true
        backgroundColor = .appGray
        addSubview(deckNameLabel)
        deckNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        deckNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
