//
//  CardBgColorController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardBgColorController: UIViewController {
    
    var alpha: CGFloat = 1
    let colorView = BackgroundColorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        handleRandomColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSubViews()
    }
    
}





