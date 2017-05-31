//
//  ViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import SwiftIconFont
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    let homeView = HomeView()

    //MenuProtocol
    var menuDelegate: UICollectionViewDelegate?
    var menuDataSource: UICollectionViewDataSource?
    
    
    var didSelectNextViewController: (IndexPath) -> () = { _ in }

    var domains: [CDDomain]?
    var tmpDomains: [Domain]!
    var domainLayer = DomainCoreData()

    
    public static let shared = HomeViewController()
    
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appGray

        setupView()
        registerCells()
        handleNavigationBars()
        
        //Domain Generation
        let dg = DomainGenerator()
        tmpDomains = dg.domains
        domains = domainLayer.fetchAllDomains()

        print(FIRAuth.auth()?.currentUser?.email)
        
        guard let firUser = FIRAuth.auth()?.currentUser?.email else { return }
        
        //TODO:- check if the user is premium user or not 
        //1. if user is premium, them searchLimit is unlimited
        //2. else the searchLimit is 5
        
        let user = User(name: firUser, email: firUser, searchLimit: 5)
        let userLayer = UserCoreDataLayer()
        userLayer.add(user)
        
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
    
    func logout() {
        navigationController?.pushViewController(PageController(), animated: true)
    }
}
