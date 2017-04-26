//
//  HomeControllerObserver.swift
//  EasyLearn
//
//  Created by Tebeen on 4/24/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class HomeControllerObserver {
    let homeView = HomeView()

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeControllerObserver.searchButtonHandler(notification:)), name: CONSTANTS.SearchButton, object: nil)
    }
    @objc func searchButtonHandler(notification: Notification){
        print("It is clicked")
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


protocol ButtonDelegate {
    func searchButton()
}
