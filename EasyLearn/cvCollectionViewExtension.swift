//
//  cvCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/25/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDataSimple.numberOfResults
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flashCV.dequeueReusableCell(withReuseIdentifier: CellID.cvCellID.rawValue, for: indexPath) as! FlashCardCell
        cell.backgroundColor = .white
        
        cell.wordName.text = currentDataSimple.fetchAllWords()?[indexPath.item].word
        //cell.wordDetails.text = currentDataSimple.fetchAllWords()?[indexPath.item].definition
        
        cell.handleSlideFlipping = {
            self.animate(from: cell.wordName, to: cell.wordDetails)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(-67, 0, -67, 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let total = currentDataSimple.numberOfResults
        
        cardNumberLabel.text = "\(indexPath.item + 1) - \(total)"
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isNavHidden = true
        isNavBarHidden(true, navigationController: navigationController, view: view)
    }
    
    func animate(from view1: UILabel, to view2: UILabel) {
        if isFlipped {
            UIView.transition(from: view1, to: view2, duration: 0.8, options: [.transitionFlipFromLeft, .showHideTransitionViews, .allowUserInteraction], completion: nil)
            isFlipped = false
        }else{
            UIView.transition(from: view2, to: view1, duration: 0.8, options: [.transitionFlipFromRight, .showHideTransitionViews, .allowUserInteraction], completion: nil)
            isFlipped = true
        }
        isNavBarHidden(true, navigationController: navigationController, view: view)
    }
}
