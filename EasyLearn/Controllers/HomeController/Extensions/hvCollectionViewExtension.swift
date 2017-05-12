//
//  CollectionViewDelegate.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.hvCellID.rawValue, for: indexPath) as! DashboardCell
        
        switch indexPath.item {
        case 0:
            cell.deckNameLabel.text = "Cards"
        case 1:
            cell.deckNameLabel.text = "Custom Cards"
        case 2:
            cell.deckNameLabel.text = "Play"
        case 3:
            cell.deckNameLabel.text = "Settings"
        default: break
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width/2 - 5, height: collectionView.frame.height/2 - 5)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if homeView.collectionVSLeadingAnchor?.constant != -200 {
            handleMenuSlide()
        } else {
            didSelectNextViewController(indexPath)
        }
    }
    
    
}
