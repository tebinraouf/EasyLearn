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

