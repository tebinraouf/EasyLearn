//
//  LoginController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/20/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var container: UIView = {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .yellow
        return vw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        view.addSubview(container)
    }
}
