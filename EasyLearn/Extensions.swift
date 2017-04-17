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
//    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
//        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: a)
//    }
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

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension UIBarButtonItem {
    public class var space: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    }
}

//public extension UIImage
//{
//    public static func icon(from font: Fonts, code: String, imageSize: CGSize, ofSize size: CGFloat) -> UIImage
//    {
//        let drawText = String.getIcon(from: font, code: code)
//        
//        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = NSTextAlignment.center
//        
//        drawText!.draw(in: CGRect(x:0, y:0, width:imageSize.width, height:imageSize.height), withAttributes: [NSFontAttributeName : UIFont.icon(from: font, ofSize: size), NSParagraphStyleAttributeName: paragraphStyle])
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return image!
//    }
//}


