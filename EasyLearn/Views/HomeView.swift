//
//  HomeView.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func handleSearch()
    func handleMoreButton()
    func handleMenuSlide()
}

class HomeView: UIView {
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        ac.translatesAutoresizingMaskIntoConstraints = false
        ac.color = .appColor
        return ac
    }()
    var logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.backgroundColor = .appColor
        iv.layer.cornerRadius = 100
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var searchTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        //textField.delegate = self
        textField.placeholder = "Search..."
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.7
        return textField
    }()
    
    var searchButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("search"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .gray
        return btn
    }()
    
    
    var moreButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("bars"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .gray
        return btn
    }()
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    lazy var collectionViewSlider: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .gray
        return cv
    }()
    
    var collectionVSLeadingAnchor: NSLayoutConstraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    
    //MARK:- Setup Views
    func setupView(){
        
        
        addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(searchTextField)
        addSubview(searchButton)
        
        searchTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 0).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        moreButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        addSubview(collectionViewSlider)
        collectionViewSlider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionVSLeadingAnchor = collectionViewSlider.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        collectionVSLeadingAnchor?.constant = -200
        collectionVSLeadingAnchor?.isActive = true
        
        
        collectionViewSlider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        collectionViewSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.isHidden = true
        
        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeView {
    public var searchText: String? {
        get {
            return searchTextField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
        }
        set {
            searchTextField.text = newValue
        }
    }
    public var searchPlaceHolder: String? {
        get {
            return searchTextField.placeholder
        }
        set {
            searchTextField.placeholder = newValue
        }
    }
    public var searchTextFieldDelegate: UITextFieldDelegate? {
        get {
            return searchTextField.delegate
        }
        set {
            searchTextField.delegate = newValue
        }
    }
}


extension HomeView {
    public func setSearchButton(_ target: Any?, action: Selector) {
        searchButton.addTarget(target, action: action, for: .touchDown)
    }
    public func setMoreButton(_ target: Any?, action: Selector) {
        moreButton.addTarget(target, action: action, for: .touchDown)
    }
}

extension HomeView {
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            return collectionView.delegate
        }
        set {
            collectionView.delegate = newValue
        }
    }
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
}
