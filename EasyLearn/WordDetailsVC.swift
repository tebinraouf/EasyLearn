//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordDetailsVC: UIViewController {
    //MARK:- Variables
    var word: Word?
    var lexicalCategory: String?
    var indexPathReference: IndexPath?
    
    let currentDataLayer = DataLayerSimple()
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .appGray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        navigationItem.title = word?.word
        setupView()
        registerCells()
        
    }
    //MARK:- Register Cells and Setup Views
    func registerCells(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
    }
    
}





















