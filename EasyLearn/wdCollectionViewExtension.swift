//
//  wordDetailsCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/23/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension WordDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = word?.details?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wdCellID.rawValue, for: indexPath) as! DetailsCell
        
        textFormatter(cell, indexPath)
        handleAddingWord(cell, indexPath)
        handleMoreDetails(cell, indexPath)
        subWordContents(cell, indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        let dvm = DetailsViewModel(word: word, indexPath: indexPath)
        let formatedString = dvm.textView
        let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}


