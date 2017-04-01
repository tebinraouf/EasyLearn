//
//  ErrorViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ErrorEmptyViewController: UIViewController {
    
    
    var delegate: HomeViewController?
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isNavBarHidden(false, navigationController)
        
        
        
        view.backgroundColor = .appGray
        setupView()
        
    }
    
    func setupView(){
        view.addSubview(messageLabel)
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
