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
    var favWords = [CDWord]()
    var isFlipped = true
    var isNavHidden = false
    let cardView = CardView()
    var cellReference: FlashCardCell?
    var indexPathReference: IndexPath?
    var isSwapped = false
    var playTimer: Timer?
    var isPlayClicked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGreen
        self.automaticallyAdjustsScrollViewInsets = false
        registerCells()
        setupView()
        handleViewGesture()
        cardView.flashCV.reloadData()
        handleNavIcons()
        playCardSpeedInitialValue()
        favWords = currentDataSimple.fetchAllWords()!
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
     
        //initial value
        UserDefaults.standard.register(defaults: [UserDefaultsKeys.cardNumberLabel.rawValue: true])
    }
    func playCardSpeedInitialValue() {
        //Initial Value for play card speed.
        let speedValue = UserDefaults.standard.double(forKey: UserDefaultsKeys.cardSpeedValue.rawValue)
        if speedValue == 0 {
            UserDefaults.standard.set(3.0, forKey: UserDefaultsKeys.cardSpeedValue.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    func registerCells() {
        cardView.flashCV.register(FlashCardCell.self, forCellWithReuseIdentifier: CellID.cvCellID.rawValue)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            cardView.flashCVTopConstraint?.constant = 10
            cardView.flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardView.flashCVTopConstraint?.isActive = true
            cardView.flashCVBottomConstraint?.isActive = true
            cardView.flashCVHeightConstraint.isActive = false
            isNavBarWithToolBarHidden(true, navigationController, cardView.toolBar)
        } else {
            cardView.flashCVTopConstraint?.isActive = false
            cardView.flashCVBottomConstraint?.isActive = false
            cardView.flashCVHeightConstraint.isActive = true
            isNavBarWithToolBarHidden(false, navigationController, cardView.toolBar)
        }
        let offset = cardView.flashCV.contentOffset
        let width  = cardView.flashCV.bounds.size.width
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        cardView.flashCV.setContentOffset(newOffset, animated: false)
        coordinator.animate(alongsideTransition: { _ in
            self.cardView.flashCV.reloadData()
            self.cardView.flashCV.setContentOffset(newOffset, animated: false)
        }, completion: nil)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cardView.flashCV.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        //Settings Update
        updateColors(cellReference)
        updateCardLabel(cellReference)
    }
    
    
}
