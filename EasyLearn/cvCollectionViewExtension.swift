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
        cell.flashCardView.wordName.text = favWords[indexPath.item].word
        
        var details = String()
        
        if let def = favWords[indexPath.item].definition {
            details.append(def)
            details.append("\n")
        }
        
        if let example = favWords[indexPath.item].example {
            details.append(example)
        }

        cell.flashCardView.wordDetails.text = details
        
        cell.handleSlideFlipping = {
            self.animate(from: cell.flashCardView.wordName, to: cell.flashCardView.wordDetails)
            
        }
        
        let total = favWords.count
        
        cell.flashCardView.cardNumber.text = "\(indexPath.item + 1) - \(total)"
        
        
        
        
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
            cell.flashCardView.wordName.isHidden = true
            cell.flashCardView.wordDetails.isHidden = false
        }else {
            cell.flashCardView.wordName.isHidden = false
            cell.flashCardView.wordDetails.isHidden = true
        }
        

        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isNavHidden = true
        isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar)
    }
    
    func animate(from view1: UILabel, to view2: UITextView) {
        
        if view1.isHidden {
            isFlipped = false
        }else{
            isFlipped = true
        }
        
        handleFlipping(from: view1, to: view2, isFlipped: &isFlipped)
        
        isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar)
    }
}
