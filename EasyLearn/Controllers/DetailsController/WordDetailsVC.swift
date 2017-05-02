//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordDetailsVC: UICollectionViewController {
    //MARK:- Variables
    var word: Word?
    var isClicked = true
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = word?.word?.capitalized
        
        collectionViewSetup()
    }
    
    //MARK:- CollectionView Usual Setup
    func collectionViewSetup(){
        collectionView?.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
        collectionView?.backgroundColor = .appGray
    }
}






