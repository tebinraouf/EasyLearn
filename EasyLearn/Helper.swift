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


public func isNavBarHidden(_ bool: Bool, navigationController: UINavigationController?, view: UIView) {
    UIView.animate(withDuration: 0.5) {
        navigationController?.isNavigationBarHidden = bool
        view.layoutIfNeeded()
    }
}
