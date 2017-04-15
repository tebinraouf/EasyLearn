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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        setupViews()
    }
}