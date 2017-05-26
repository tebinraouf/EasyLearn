//
//  OverrideFuncs.swift
//  EasyLearn
//
//  Created by Tebeen on 5/26/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension PageController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageView.currentPage = pageNumber
        prepareLoginPage(pageNumber)
    }
    func prepareLoginPage(_ pageNumber: Int){
        if pageNumber == pages.count {
            pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
        }else {
            pageView.updateConstraintFor(getStarted: 0, pageControl: 0, loginView: 400, facebookBtn: 400)
        }
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
