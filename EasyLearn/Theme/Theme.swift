//
//  Theme.swift
//  EasyLearn
//
//  Created by Tebeen on 5/11/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit


enum Theme: Int {
    
    case custom
    
    static var current: Theme {
        return .custom
    }
    
    var mainColor: UIColor {
        switch self {
        case .custom:
            return .appColor
        }
    }
    
    func apply() {
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        UINavigationBar.appearance().barTintColor = .appGray
        
        
        //Controls
        UISwitch.appearance().onTintColor = mainColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = mainColor
        
        UISlider.appearance().tintColor = mainColor
        
    }
    
}
