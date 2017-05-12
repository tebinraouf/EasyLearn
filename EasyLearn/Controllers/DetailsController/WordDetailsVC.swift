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
    var word: Word!
    var isClicked = true
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = word?.word.capitalized
        navigationController?.navigationBar.isTranslucent = false
        collectionViewSetup()
    }
    
    //MARK:- CollectionView Usual Setup
    func collectionViewSetup(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
        collectionView.backgroundColor = .appGray
        setupView()
    }
    
    //MARK: SetupView
    func setupView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
    }
}






