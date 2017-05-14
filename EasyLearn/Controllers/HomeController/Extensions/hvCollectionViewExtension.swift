//
//  CollectionViewDelegate.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.hvCellID.rawValue, for: indexPath) as! DashboardCell

        
        if domains?.count == 0 {
            cell.deckNameLabel.text = tmpDomains[indexPath.item].name
        } else {
            cell.deckNameLabel.text = domains?[indexPath.item].name
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 40)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if homeView.collectionVSLeadingAnchor?.constant != -200 {
            handleMenuSlide()
        } else {
            //didSelectNextViewController(indexPath)
            
            let dwc = DomainWordsController()
            
            if domains?.count == 0 {
                dwc.domain = tmpDomains[indexPath.item]
            } else {
                let name = domains?[indexPath.item].name
                let key = domains?[indexPath.item].key
                let domain = Domain(key: key!, name: name!)
                dwc.domain = domain
            }

            
            if Reachability.isConnectedToNetwork {
                let web = WebService(tmpDomains[indexPath.item].key)
                web.getDomainWords { (words, status) in
                    dwc.words = words
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(dwc, animated: true)
                    }
                }
                
                if web.request != nil {
                    homeView.containerView.isHidden = false
                    homeView.activityIndicatorView.startAnimating()
                }
                
                
            } else {
                noInternetAlert(self)
            }
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
