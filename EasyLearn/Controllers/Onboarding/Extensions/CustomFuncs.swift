//
//  CustomFuncs.swift
//  EasyLearn
//
//  Created by Tebeen on 5/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

extension PageController {
    func setupView(){
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func isLoginPage(_ bool: Bool, _ cell: PageCell){
        cell.background.isHidden = bool
        cell.descriptionLabel.isHidden = bool
        cell.titleLabel.isHidden = bool
    }
    func setDelegates(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        pageView.setTextFieldsDelegate(self)
        pageView.loginDelegate = self
        pageView.facebookLoginDelegate = self
    }
}
