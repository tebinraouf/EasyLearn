//
//  MenuModel.swift
//  EasyLearn
//
//  Created by Tebeen on 5/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit


//MARK:- Menu Model & Creator
struct MenuButton {
    var id: Int
    var icon: String?
    var title: String?
}
struct MenuButtonCreator {
    private var buttons: [MenuButton]
    var count: Int {
        return buttons.count
    }
    init() {
        buttons = [MenuButton]()
        //initial letter for the first one...
        let menu0 = MenuButton(id: 0, icon: "T", title: "account")
        let menu1 = MenuButton(id: 1, icon: "sign-out", title: "logout")
        let menu2 = MenuButton(id: 2, icon: "shopping-cart", title: "purchase")
        let menu3 = MenuButton(id: 3, icon: "comment", title: "feedback")
        buttons = [menu0, menu1, menu2, menu3]
    }
    func buttonAt(_ indexPath: IndexPath) -> MenuButton {
        return buttons[indexPath.item]
    }
}

