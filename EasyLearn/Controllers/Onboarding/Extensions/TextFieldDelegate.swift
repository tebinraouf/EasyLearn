//
//  TextFieldDelegate.swift
//  EasyLearn
//
//  Created by Tebeen on 5/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension PageController: UITextFieldDelegate {
    //MARK: Handle Keyboard Dismissal
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pageView.keyboardResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pageView.keyboardResponder()
        return true
    }
}

