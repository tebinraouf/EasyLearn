//
//  Helper.swift
//  EasyLearn
//
//  Created by Tebeen on 3/25/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation


enum CellID: String {
    case hvCellID
    case wdCellID
    case wsdCellID
    case cvCellID
    case cvFooterID
}

enum UserDefaultsKeys: String {
    case cardSpeedValue
    case cardNumberLabel
}


public func isNavBarWithToolBarHidden(_ bool: Bool, _ navigationController: UINavigationController?, _ toolBar: UIToolbar) {
    
    UIView.animate(withDuration: 0.9, delay: 0, options: .transitionCurlUp, animations: {
        if bool {
            navigationController?.navigationBar.alpha = 0
            toolBar.alpha = 0
        }else{
            navigationController?.navigationBar.alpha = 1
            toolBar.alpha = 1
        }
    }, completion: nil)
}

public func isNavBarHidden(_ bool: Bool, _ navigationController: UINavigationController?) {
    UIView.animate(withDuration: 0.5) {
        navigationController?.isNavigationBarHidden = bool
    }
}

public func progressImage(with progress: Float, color: UIColor, textColor: UIColor) -> UIImage {
    let layer = CALayer()
    layer.backgroundColor = color.cgColor
    layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    layer.cornerRadius = 15
    
    let label = UILabel(frame: layer.frame)
    label.text = "\(Int(progress.rounded()))"
    label.font = UIFont.systemFont(ofSize: 10)
    label.textColor = textColor
    layer.addSublayer(label.layer)
    label.textAlignment = .center
    label.tag = 100
    
    //UIGraphicsBeginImageContext(layer.frame.size) //this uses a scale one 1
    //use the following func with third parameter of 0.0
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
    
    layer.render(in: UIGraphicsGetCurrentContext()!)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
public func DegreesToRadians (_ value:CGFloat) -> CGFloat {
    return value * CGFloat(Double.pi) / 180.0
}

public func setUserSettings(for value: Float, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func setUserSettings(for value: CGFloat, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}


