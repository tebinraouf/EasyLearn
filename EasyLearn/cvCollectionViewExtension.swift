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
        let cell = cardView.flashCV.dequeueReusableCell(withReuseIdentifier: CellID.cvCellID.rawValue, for: indexPath) as! FlashCardCell
        
        cellReference = cell
        cell.wordName.text = favWords[indexPath.item].word
        
        var details = String()
        
        if let def = favWords[indexPath.item].definition {
            details.append(def)
            details.append("\n")
        }
        
        if let example = favWords[indexPath.item].example {
            details.append(example)
        }

        cell.wordDetails.text = details
        
        cell.handleSlideFlipping = {
            self.animate(from: cell.wordName, to: cell.wordDetails)
            
        }
        let total = favWords.count
        cell.cardNumber.text = "\(indexPath.item + 1) - \(total)"
        
        
        indexPathReference = indexPath
        
        
        view.backgroundColor = .orange
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cardView.flashCV.frame.width, height: cardView.flashCV.frame.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(-67, 0, -67, 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        let cell = cell as! FlashCardCell
        if isSwapped {
            cell.wordName.isHidden = true
            cell.wordDetails.isHidden = false
        }else {
            cell.wordName.isHidden = false
            cell.wordDetails.isHidden = true
        }
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isNavHidden = true
        isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar, cardView.navBar)
    }
    
    func animate(from view1: UILabel, to view2: UITextView) {
        
        if view1.isHidden {
            isFlipped = false
        }else{
            isFlipped = true
        }
        
        handleFlipping(from: view1, to: view2)
        
        isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar, cardView.navBar)
    }
    
    
    func handleFlipping(from view1: UILabel, to view2: UITextView){
        if isFlipped {
            UIView.transition(from: view1, to: view2, duration: 0.8, options: [.transitionFlipFromLeft, .showHideTransitionViews, .allowUserInteraction], completion: nil)
            isFlipped = false
        }else{
            UIView.transition(from: view2, to: view1, duration: 0.8, options: [.transitionFlipFromRight, .showHideTransitionViews, .allowUserInteraction], completion: nil)
            isFlipped = true
        }
    }
}
