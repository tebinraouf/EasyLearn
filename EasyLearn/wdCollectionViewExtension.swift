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
        //cell.backgroundColor = .blue
        
        
        if let formatedString = formatedStringForTextAt(indexPath) {
            cell.numberCircle.text = "\(indexPath.item+1)"
            cell.textView.attributedText = formatedString
        }
        
        cell.completion = {
            //print(self.word?.details?[indexPath.item].definition)
            
            let id = self.word?.details?[indexPath.item].wordId
            let language = self.word?.language
            let lexicalEntry = self.lexicalCategory
            let word = self.word?.word
            let type = self.word?.type
            let examples = self.word?.details?[indexPath.item].examples

            let definition = self.word?.details?[indexPath.item].definition

            self.currentDataLayer.saveWord(id, language, lexicalEntry, word, type, examples, definition)
            
        
        }
        
        if word?.details?[indexPath.item].subdetails?.count == 0 {
            cell.btnMoreDetails.isHidden = true
            
        } else {
            cell.btnMoreDetails.isHidden = false
        }
        
        cell.handleSubWordCompletion = {
            let subDetailsController = WordSubDetailsVC()
            subDetailsController.wdDelegate = self
            subDetailsController.wordDetail = self.word?.details?[indexPath.item]
            self.navigationController?.pushViewController(subDetailsController, animated: true)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        if let formatedString = formatedStringForTextAt(indexPath) {
            let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
            return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
        }
        return size
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
