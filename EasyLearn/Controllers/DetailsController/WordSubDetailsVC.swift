//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordSubDetailsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var wordDetail: Detail!
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        collectionViewSetup()
    }
    //MARK:- CollectionView Usual Setup
    func collectionViewSetup(){
        collectionView?.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wsdCellID.rawValue)
        collectionView?.backgroundColor = .appGray
    }
    //MARK:- Collection View Functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordDetail.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wsdCellID.rawValue, for: indexPath) as! DetailsCell
        //cell.backgroundColor = .blue
        
        let generator = DataGenerator(wordDetail!, indexPath)
        let cellData = DetailCellData(generator, cell)
        cellData.populateCell()
        
        let interaction = UserInteraction(target: self, wordDetail, cell, indexPath)
        interaction.didInteract()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //give a very large height
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        let generator = DataGenerator(wordDetail, indexPath)
        let formatedString = generator.cellText
        let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(word?.details?[indexPath.item].subdetails?[indexPath.item].subDefinition)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //let top: CGFloat = DeviceState.isPortrait.state ? 64 : 35
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView.scrollIndicatorInsets
    }
}





















