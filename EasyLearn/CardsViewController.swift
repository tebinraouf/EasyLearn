//
//  CardsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
class CardsViewController: UIViewController {
    //computed variables
    
    let currentDataSimple = DataLayerSimple()
    var isFlipped = true
    
    var isNavHidden = false
    
    let cardView = CardView()
    var mostRecentOffset : CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGreen
        registerCells()
        setupView()
        handleViewGesture()
        self.automaticallyAdjustsScrollViewInsets = false
        cardView.flashCV.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardView.flashCV.reloadData()
    }
    func registerCells(){
        cardView.flashCV.register(FlashCardCell.self, forCellWithReuseIdentifier: CellID.cvCellID.rawValue)
        //flashCV.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CellID.cvFooterID.rawValue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            cardView.flashCVTopConstraint?.constant = 10
            cardView.flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardView.cardNumberLabelBottomConstraint?.constant = -10
            cardView.checkButtonBottomConstraint?.constant = -10
            isNavBarHidden(true, navigationController: navigationController, view: view)
        } else {
            cardView.flashCVTopConstraint?.constant = 100
            cardView.flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardView.cardNumberLabelBottomConstraint?.constant = -70
            cardView.checkButtonBottomConstraint?.constant = -70
            isNavBarHidden(false, navigationController: navigationController, view: view)
        }
        cardView.flashCV.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cardView.flashCV.collectionViewLayout.invalidateLayout()
    }
    
}



