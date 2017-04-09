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
    //MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        registerCells()
        
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
    
}
