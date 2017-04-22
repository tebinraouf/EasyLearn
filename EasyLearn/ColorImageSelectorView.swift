//
//  ColorImageSelectorView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ColorImageSelectorView: UIView {
    let mainCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLightGreen
        return view
    }()
    let sampleCardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    let labelViews: FlashCardView = {
        let lv = FlashCardView()
        lv.wordName.font = UIFont.systemFont(ofSize: 20)
        return lv
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    //Property 01
    var wordNameBgColor: UIColor? {
        get {
            return labelViews.wordName.backgroundColor
        }
        set {
            labelViews.wordName.backgroundColor = newValue
        }
    }
    var wordDetailsBgColor: UIColor? {
        get {
            return labelViews.wordDetails.backgroundColor
        }
        set {
            labelViews.wordDetails.backgroundColor = newValue
        }
    }
    //Property 02
    var wordNameTextColor: UIColor? {
        get {
            return labelViews.wordName.textColor
        }
        set {
            labelViews.wordName.textColor = newValue
        }
    }
    var wordDetailsTextColor: UIColor? {
        get {
            return labelViews.wordDetails.textColor
        }
        set {
            labelViews.wordDetails.textColor = newValue
        }
    }
    var cardNumberTextColor: UIColor? {
        get {
            return labelViews.cardNumber.textColor
        }
        set {
            labelViews.cardNumber.textColor = newValue
        }
    }
    //Property 01
    var viewBgColor: UIColor? {
        get {
            return mainCardView.backgroundColor
        }
        set {
            mainCardView.backgroundColor = newValue
        }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func addSubViews(){
        addSubview(mainCardView)
        mainCardView.addSubview(sampleCardView)
        sampleCardView.addSubview(labelViews)
        addSubview(collectionView)
    }
    func setupView(){
        addSubViews()
        setupCardViewMain()
        setupSampleCardView()
        setupLabelViews()
        setupCollectionView()
    }
    func setupCardViewMain(){
        NSLayoutConstraint.activate([
            mainCardView.topAnchor.constraint(equalTo: topAnchor),
            mainCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33)
        ])
    }
    func setupSampleCardView(){
        NSLayoutConstraint.activate([
            sampleCardView.topAnchor.constraint(equalTo: mainCardView.topAnchor, constant: 10),
            sampleCardView.bottomAnchor.constraint(equalTo: mainCardView.bottomAnchor, constant: -10),
            sampleCardView.leadingAnchor.constraint(equalTo: mainCardView.leadingAnchor, constant: 80),
            sampleCardView.trailingAnchor.constraint(equalTo: mainCardView.trailingAnchor, constant: -80)
        ])
    }
    func setupLabelViews(){
        NSLayoutConstraint.activate([
            labelViews.topAnchor.constraint(equalTo: sampleCardView.topAnchor),
            labelViews.bottomAnchor.constraint(equalTo: sampleCardView.bottomAnchor),
            labelViews.leadingAnchor.constraint(equalTo: sampleCardView.leadingAnchor),
            labelViews.trailingAnchor.constraint(equalTo: sampleCardView.trailingAnchor)
        ])
    }
    func setupCollectionView(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: mainCardView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
