//
//  MenuCollectionViewMethods.swift
//  EasyLearn
//
//  Created by Tebeen on 5/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit


//MARK:- CollectionViewSlider Delegate & Data Source
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewSlider.dequeueReusableCell(withReuseIdentifier: CellID.menuCell.rawValue, for: indexPath) as! MenuCell
        cell.menuButton = menus.buttonAt(indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func registerCell(){
        collectionViewSlider.dataSource = self
        collectionViewSlider.delegate = self
        collectionViewSlider.register(MenuCell.self, forCellWithReuseIdentifier: CellID.menuCell.rawValue)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = MenuSelector(rawValue: indexPath.item)
        var action = MenuAction(menu!)
        action.navigationController = navigationController
        action.homeController = homeController
        action.setMenuAction()
    }
}


