//
//  MenuButtonView.swift
//  EasyLearn
//
//  Created by Tebeen on 5/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class MenuButtonView: UIView {
    var container: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 30
        vw.layer.masksToBounds = true
        vw.backgroundColor = .appRedish
        //vw.layer.borderColor = UIColor.black.cgColor
        //vw.layer.borderWidth = 1
        return vw
    }()
    var icon: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.icon(from: .FontAwesome, ofSize: 30)
        label.text = String.fontAwesomeIcon("sign-out")
        label.textColor = .appGray
        label.textAlignment = .center
        return label
    }()
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "logout"
        label.textColor = .appGray
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }
    func setupView(){
        addViews()
        setupContainer()
        setupIcon()
        setupTitle()
        
    }
    func addViews(){
        addSubview(container)
        container.addSubview(icon)
        container.addSubview(title)
    }
    func setupContainer(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    func setupIcon(){
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            icon.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            //icon.bottomAnchor.constraint(equalTo: title.topAnchor)
            ])
    }
    func setupTitle(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 5),
            title.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
