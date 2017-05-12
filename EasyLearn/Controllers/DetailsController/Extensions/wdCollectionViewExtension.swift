//
//  wordDetailsCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/23/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension WordDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return word.count
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
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tap Tap More...")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}


enum DeviceState {
    case isLanscape
    case isPortrait
    var state: Bool {
        switch self {
        case .isLanscape:
            return UIDevice.current.orientation.isLandscape
        case .isPortrait:
            return UIDevice.current.orientation.isPortrait
        }
    }
}



