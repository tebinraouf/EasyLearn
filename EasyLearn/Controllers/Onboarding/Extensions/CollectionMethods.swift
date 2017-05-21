//
//  CollectionMethods.swift
//  EasyLearn
//
//  Created by Tebeen on 5/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension PageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        
        if indexPath.item != 3 {
            cell.page = pages[indexPath.item]
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //var inset = collectionView.contentInset.
        
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! PageCell
        //handle cell UI
        if indexPath.item == pages.count {
            isLoginPage(true, cell)
        }else {
            isLoginPage(false, cell)
        }
    }
    
}
