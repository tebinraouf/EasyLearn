//
//  CardsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
class CardsViewController: UIViewController, UIGestureRecognizerDelegate {
    //computed variables
    
    let currentDataSimple = DataLayerSimple()
    var favWords = [CDWord]()
    var isFlipped = true
    
    var isNavHidden = false
    
    let cardView = CardView()
    
    var cellReference: FlashCardCell?
    var indexPathReference: IndexPath?
    var isSwapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGreen
        self.automaticallyAdjustsScrollViewInsets = false
        registerCells()
        setupView()
        handleViewGesture()
        cardView.flashCV.reloadData()
        handleNavIcons()
        
        
        favWords = currentDataSimple.fetchAllWords()!
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let total = currentDataSimple.numberOfResults
        cardView.cardNumberLabel.text = "1 - \(total)"
        cardView.flashCV.reloadData()
        
    }
    
    func registerCells(){
        cardView.flashCV.register(FlashCardCell.self, forCellWithReuseIdentifier: CellID.cvCellID.rawValue)
        //flashCV.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CellID.cvFooterID.rawValue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        
        if UIDevice.current.orientation.isLandscape {
            
            cardView.flashCVTopConstraint?.constant = 10
            cardView.flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardView.cardNumberLabelBottomConstraint?.constant = -10
            cardView.checkButtonBottomConstraint?.constant = -10
            
            cardView.flashCVTopConstraint?.isActive = true
            cardView.flashCVBottomConstraint?.isActive = true
            cardView.flashCVHeightConstraint.isActive = false
            
            isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar, cardView.navBar)
            
        } else {
            
            cardView.flashCVTopConstraint?.isActive = false
            cardView.flashCVBottomConstraint?.isActive = false
            cardView.flashCVHeightConstraint.isActive = true
            
            cardView.cardNumberLabelBottomConstraint?.constant = -70
            cardView.checkButtonBottomConstraint?.constant = -70
            isNavBarWithToolBarHidden(false, navigationController, cardView.toolBar, cardView.navBar)
        }
        
        
        
        
        let offset = cardView.flashCV.contentOffset;
        let width  = cardView.flashCV.bounds.size.width;
        
        let index     = round(offset.x / width);
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        cardView.flashCV.setContentOffset(newOffset, animated: false)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.cardView.flashCV.reloadData()
            self.cardView.flashCV.setContentOffset(newOffset, animated: false)
        }, completion: nil)
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cardView.flashCV.collectionViewLayout.invalidateLayout()
    }
    
}



