//
//  ColorImageCell.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ColorImageCell: BaseCell {
    var sectionTitle: LeftPaddedUILabel = {
        let label = LeftPaddedUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Section Label"
        label.backgroundColor = .appGray
        return label
    }()
    lazy var subCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .appGray
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    let colors = ColorCellsViewModel()
    var handleCellClick: ((_ indexPath: IndexPath)->())?
    
    override func setupView() {
        addSubviews()
        setupSectionTitle()
        setupCollectionView()
        registerCells()
    }
    func addSubviews(){
        addSubview(sectionTitle)
        addSubview(subCollectionView)
    }
    func setupSectionTitle(){
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: topAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setupCollectionView(){
        NSLayoutConstraint.activate([
            subCollectionView.topAnchor.constraint(equalTo: sectionTitle.bottomAnchor),
            subCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            subCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}
extension ColorImageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerCells(){
        subCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellID.cisSelectorCell.rawValue)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.cisSelectorCell.rawValue, for: indexPath)
        cell.backgroundColor = colors.backgroundColorForItemAt(indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 100, height: 100)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCellClick?(indexPath)
    }
}
