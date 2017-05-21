//
//  PageOneController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    let pageView = PageView()
    
    let pages: [Page] = {
        let firstPage = Page(title: "Word Definition", description: "Search for the most sophisticated word. Powered by Oxford Dictionaries.", image: #imageLiteral(resourceName: "search"))
        let secondPage = Page(title: "Custom Card", description: "Study words by using auto created cards and design your own cards.", image: #imageLiteral(resourceName: "card"))
        let thirdPage = Page(title: "Word Category", description: "Study words by categories. Choose from 200+ categories.", image: #imageLiteral(resourceName: "category"))
        return [firstPage, secondPage, thirdPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupView()
    }
    func handleGetStarted(){
        print(1234)
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}



//custom funcs
extension PageController {
    func isLoginPage(_ bool: Bool, _ cell: PageCell){
        cell.background.isHidden = bool
        cell.descriptionLabel.isHidden = bool
        cell.titleLabel.isHidden = bool
    }
}

extension PageController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageView.currentPage = pageNumber
        
        if pageNumber == pages.count {
            pageView.getStartedConstantConstraint = -300
            pageView.pageControlConstantConstraint = -300
        }else {
            pageView.getStartedConstantConstraint = 0
            pageView.pageControlConstantConstraint = 0
        }
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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


extension PageController {
    func setupView(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}







