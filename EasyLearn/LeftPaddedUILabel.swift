//
//  LeftPaddedUILabel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/8/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class LeftPaddedUILabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
