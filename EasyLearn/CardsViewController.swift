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
    lazy var flashCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 - 10"
        label.textColor = .yellow
        return label
    }()
    
    var checkButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("check"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.layer.backgroundColor = UIColor.lightGray.cgColor
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .gray
        return btn
    }()
    
    let currentDataSimple = DataLayerSimple()
    var isFlipped = true
    
    var isNavHidden = false
    var flashCVTopConstraint: NSLayoutConstraint?
    var flashCVBottomConstraint: NSLayoutConstraint?
    var cardNumberLabelBottomConstraint: NSLayoutConstraint?
    var checkButtonBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGreen
        registerCells()
        setupView()
        handleViewGesture()
        self.automaticallyAdjustsScrollViewInsets = false
        flashCV.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashCV.reloadData()
    }
    func registerCells(){
        flashCV.register(FlashCardCell.self, forCellWithReuseIdentifier: CellID.cvCellID.rawValue)
        //flashCV.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CellID.cvFooterID.rawValue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        if UIDevice.current.orientation.isLandscape {
            flashCVTopConstraint?.constant = 10
            flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardNumberLabelBottomConstraint?.constant = -10
            checkButtonBottomConstraint?.constant = -10
            isNavBarHidden(true, navigationController: navigationController, view: view)
        } else {
            flashCVTopConstraint?.constant = 100
            flashCVBottomConstraint?.constant = -10 //doesn't change but we need this later
            cardNumberLabelBottomConstraint?.constant = -70
            checkButtonBottomConstraint?.constant = -70
            isNavBarHidden(false, navigationController: navigationController, view: view)
        }
        flashCV.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        flashCV.collectionViewLayout.invalidateLayout()
    }
    
}

