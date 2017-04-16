//
//  ColorImageSelector.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ColorImageSelector: UIViewController {
    
    let selectorView = ColorImageSelectorView()
    var isFlipped = true
    
    var sectionTitles = ["Card Background Color", "Text Color", "View Background Color", "Card Background Image"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupDelegateDataSource()
        
    }
}
