//
//  PageOneController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit

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


extension PageController {
    func setupView(){
        pageView.collectionViewDelegate = self
        pageView.collectionViewDataSource = self
        pageView.setTextFieldsDelegate(self)
        pageView.loginDelegate = self
        pageView.facebookLoginDelegate = self
        
        view.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}


extension PageController: LoginViewDelegate {
    
    func loginBtn() {
        print("Login btn")
    }
    func registerBtn() {
        print("Register btn")
    }
    func forgetPasswordBtn() {
        print("password btn")
    }
    func getStartedBtn() {
        let indexPath = IndexPath(item: 3, section: 0)
        pageView.pageCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
        pageView.updateConstraintFor(getStarted: -300, pageControl: -300, loginView: 0, facebookBtn: 0)
    }
}


//Facebook Login Button Delegate 

extension PageController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        switch result {
        case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
            
            let request = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])
            request?.start { (connection, result, error) in
                print(connection)
                //print(result)
            }
            
        case .cancelled:
            print("User cancelled login.")
        case .failed(let error):
            print(error)
        }
        
        
    }
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logout")
    }
}





