//
//  UITableViewControllerWithViews.swift
//  EasyLearn
//
//  Created by Tebeen on 5/13/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class UITableViewControllerWithViews: UITableViewController {
    var activityIndicatorView: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        ac.translatesAutoresizingMaskIntoConstraints = false
        ac.color = .appColor
        return ac
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func setupView() {
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicatorView.stopAnimating()
    }
}
