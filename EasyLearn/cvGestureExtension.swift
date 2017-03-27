//
//  cvGestureExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardsViewController {
    func handleViewGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        view.addGestureRecognizer(tap)
    }
    func handleViewTap(){
        isNavBarHidden(!isNavHidden, navigationController: navigationController, view: view)
        isNavHidden = !isNavHidden
    }
}
