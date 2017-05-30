//
//  MenuCell.swift
//  EasyLearn
//
//  Created by Tebeen on 5/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    let menuButtonView = MenuButtonView()
    var menuButton: MenuButton? {
        didSet {
            guard let menuButton = menuButton else { return }
            guard let mBtnLabel = menuButton.icon else { return }
            guard let mBtnTitle = menuButton.title else { return }

            menuButtonView.icon.text = menuButton.id == 0 ? "T" : String.fontAwesomeIcon(mBtnLabel)
            menuButtonView.title.text = mBtnTitle
        }
    }
    override func setupView() {
        backgroundColor = .clear
        addViews()
        setupMenuButtonView()
    }
    func addViews(){
        addSubview(menuButtonView)
    }
    func setupMenuButtonView(){
        NSLayoutConstraint.activate([
            menuButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            menuButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            menuButtonView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
            ])
    }
}






