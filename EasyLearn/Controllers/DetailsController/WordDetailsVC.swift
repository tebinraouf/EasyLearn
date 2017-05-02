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
    var isClicked = true
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .appGray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    var layout: MainLayout?
    
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        navigationItem.title = word?.word
        //setupView()
        //registerCells()
        
        
        layout = MainLayout(target: self)
        layout?.layout(in: view)
        
    }
    
    //MARK:- Register Cells and Setup Views
    func registerCells(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
    }
}

extension WordDetailsVC  {
    func setupView(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

struct MainLayout {
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .appGray
        return cv
    }()
    private var target: UIViewController
    
    public init(target: UIViewController) {
        self.target = target
        collectionView.dataSource = target as? UICollectionViewDataSource
        collectionView.delegate = target as? UICollectionViewDelegate
    }
    
    mutating func layout(in view: UIView) {
        setupView(in: view)
        registerCells()
    }
    mutating func registerCells(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
    }
    
    mutating func reload() {
        collectionView.reloadData()
    }
    
    private mutating func setupView(in view: UIView){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: target.topLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}








