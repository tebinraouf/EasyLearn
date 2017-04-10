//
//  CardSettingsController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/7/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardSettingsController: UIViewController {
    
    let sections = ["Play Speed", "Hide/Show", "Colors", "Flipping","Background Image"]
    
    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        registerCells()
        setupView()
    }
    
    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
    }

    
}


class NavigationControllerNoAutorotate: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
}







