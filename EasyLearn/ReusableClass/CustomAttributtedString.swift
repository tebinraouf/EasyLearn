//
//  CustomAttributtedString.swift
//  EasyLearn
//
//  Created by Tebeen on 4/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CustomAttributtedString {
    private var text: String
    private var fontSize: CGFloat = UIFont.systemFontSize
    private var systemFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    private var textColor: UIColor = .black
    
    public var size: CGFloat {
        get {
            return fontSize
        }
        set {
            fontSize = newValue
        }
    }
    public var font: UIFont {
        get {
            return systemFont
        }
        set {
            systemFont = newValue
        }
    }
    public var color: UIColor {
        get {
            return textColor
        }
        set {
            textColor = newValue
        }
    }
    
    public init(text: String) {
        self.text = text
    }
    public func getAttributtedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes: [
            NSFontAttributeName:UIFont(name: font.fontName, size: size)!,
            NSForegroundColorAttributeName:UIColor(cgColor: color.cgColor)
            ])
    }
}
