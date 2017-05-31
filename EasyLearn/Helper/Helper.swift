//
//  Helper.swift
//  EasyLearn
//
//  Created by Tebeen on 3/25/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import FBSDKLoginKit


class CONSTANTS {
    static let SearchButton = Notification.Name("HomeViewControllerSearchButton")
}

enum CellID: String {
    case hvCellID
    case wdCellID
    case wsdCellID
    case cvCellID
    case cvFooterID
    case cisSelector
    case cisSelectorCell
    case pcCellID
    case menuCell
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

public func progressImage(with progress: Int16, color: UIColor, textColor: UIColor) -> UIImage {
    let layer = CALayer()
    layer.backgroundColor = color.cgColor
    layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    layer.cornerRadius = 15
    
    let label = UILabel(frame: layer.frame)
    label.text = "\(progress)"
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
public func setUserSettings(for value: Int16, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func setUserSettings(for value: Int, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func setUserSettings(for value: Float, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func setUserSettings(for value: CGFloat, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public func setUserSettings(for value: Bool, forKey: String) {
    UserDefaults.standard.setValue(value, forKey: forKey)
    UserDefaults.standard.synchronize()
}
public var isLoggedIn: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    set {
        setUserSettings(for: newValue, forKey: "isLoggedIn")
    }
}

public var isReachedSearchLimit: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isReachedSearchLimit")
    }
    set {
        setUserSettings(for: newValue, forKey: "isReachedSearchLimit")
    }
}
public var searchLimitCount: Int {
    get {
        return UserDefaults.standard.integer(forKey: "searchLimitCount")
    }
    set {
        setUserSettings(for: newValue, forKey: "searchLimitCount")
    }
}


public func handleFlipping(from view1: UILabel, to view2: UITextView, isFlipped: inout Bool){
    if isFlipped {
        UIView.transition(from: view1, to: view2, duration: 0.8, options: [.transitionFlipFromLeft, .showHideTransitionViews, .allowUserInteraction], completion: nil)
        isFlipped = false
    }else{
        UIView.transition(from: view2, to: view1, duration: 0.8, options: [.transitionFlipFromRight, .showHideTransitionViews, .allowUserInteraction], completion: nil)
        isFlipped = true
    }
}


func alert(title: String, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    viewController.present(alert, animated: true)
}
