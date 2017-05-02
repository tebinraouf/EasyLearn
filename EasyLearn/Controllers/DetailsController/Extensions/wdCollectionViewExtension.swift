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
        
        let generator = DataGenerator(word!, indexPath)
        let cellData = DetailCellData(generator, cell)
        cellData.populateCell()
        
        
        let interaction = UserInteraction(target: self, word!, cell, indexPath)
        interaction.didInteract()
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        let generator = DataGenerator(word!, indexPath)
        let formatedString = generator.cellText
        let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        layout?.invalidate()
        DispatchQueue.main.async {
            self.layout?.reload()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tap Tap More...")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

