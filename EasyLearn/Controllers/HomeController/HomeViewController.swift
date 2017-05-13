//
//  ViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import SwiftIconFont

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    let homeView = HomeView()
    var didSelectNextViewController: (IndexPath) -> () = { _ in }
    var homeViewAction = HomeVCAction()

    var domains: [CDDomain]?
    var tmpDomains: [Domain]!
    var domainLayer = DomainCoreData()
    
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appGray
        
        setupView()
        registerCells()
        handleNavigationBars()
        
        homeViewAction.homeView = homeView
        homeViewAction.view = view
        homeViewAction.navigationController = navigationController
        
        let dg = DomainGenerator()
        tmpDomains = dg.domains
        
        domains = domainLayer.fetchAllDomains()
    }
    
    
    
    
    //MARK:- Register Cells
    func registerCells(){
        homeView.collectionView.register(DashboardCell.self, forCellWithReuseIdentifier: CellID.hvCellID.rawValue)
    }
    
    //MARK:- Handle Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        homeView.searchTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSearch()
        homeView.searchTextField.resignFirstResponder()
        return true
    }
    //MARK: Navigation Bar
    func handleNavigationBars(){
        let back = UIBarButtonItem(title: "Home", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = back
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        homeView.containerView.isHidden = true
        homeView.activityIndicatorView.stopAnimating()
        navigationController?.setNavigationBarHidden(true, animated: true)
        homeView.collectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        homeView.collectionView.reloadData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        handleDomains()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func handleDomains() {
        
        let domainCoreData = DomainCoreData()

        //then save domains from the server into core data
        let web = WebService()
        if domainCoreData.fetchAllDomains()?.count == 0 {
            web.getDomains { (domains, status) in
                for domain in domains! {
                    domainCoreData.saveDomain(domain.name, key: domain.key)
                }
                print(domains ?? "")
            }
        }
        
        
        
        
    }
    

}

extension HomeViewController {
    var getNextViewController: (Word?, Status) -> () {
        get {
            return homeViewAction.pushToNextViewController
        }
        set {
            homeViewAction.pushToNextViewController = newValue
        }
    }
}
