//
//  Extensions.swift
//  EasyLearn
//
//  Created by Tebeen on 3/4/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    public class var appColor: UIColor {
        return UIColor(r: 255, g: 20, b: 106, a: 1)
    }
    public class var appGray: UIColor {
        return UIColor(r: 247, g: 247, b: 247, a: 1)
    }
    public class var appRedish: UIColor {
        return UIColor(r: 244, g: 91, b: 105, a: 1)
    }
    public class var appLightGreen: UIColor {
        return UIColor(r: 220, g: 226, b: 202, a: 1)
    }
    
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}





