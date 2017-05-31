//
//  PageOneController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

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
        setDelegates()
        setupView()
    }
    func handleGetStarted(){
        print(1234)
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}


struct User: Equatable {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }

    var name: String
    var email: String
    var searchLimit: Int32
}

