//
//  cisCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension ColorImageSelector: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func setupDelegateDataSource(){
        selectorView.collectionView.delegate = self
        selectorView.collectionView.dataSource = self
        registerCells()
    }
    func registerCells(){
        selectorView.collectionView.register(ColorImageCell.self, forCellWithReuseIdentifier: CellID.cisSelector.rawValue)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.cisSelector.rawValue, for: indexPath) as! ColorImageCell
        cell.sectionTitle.text = sectionTitles[indexPath.item]
        
        cell.handleCellClick = { cellItemIndex in
            self.handleClicks(row: indexPath, item: cellItemIndex)
        }
        cell.backgroundColor = .clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: selectorView.frame.width, height: 130)
        return size
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        selectorView.collectionView.reloadData()
    }
    func handleClicks(row: IndexPath, item: IndexPath){
        print("Row: ", row, "Item: ", item)
        selectorView.labelViews.wordName.text = "\(item)"
    }

}
