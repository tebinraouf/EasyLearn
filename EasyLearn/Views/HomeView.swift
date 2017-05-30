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
    func handleCard()
    func handleMoreCategory()
    func handleTapTopContainer()
}

class HomeView: UIView {
    var navigationController: UINavigationController?
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    var topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appRedish
        return view
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        ac.translatesAutoresizingMaskIntoConstraints = false
        ac.color = .appColor
        return ac
    }()
    var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Easylearn"
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "PingFang SC", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var categoryBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("Categories...", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .appColor
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        btn.addTarget(self, action: #selector(moreCategoryBtn), for: .touchDown)
        return btn
    }()
    lazy var searchTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        //textField.delegate = self
        textField.textColor = .white
        textField.tintColor = .white
        textField.placeholder = "Search..."
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.7
        return textField
    }()
    var searchButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("search"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(searchBtn), for: .touchDown)
        return btn
    }()
    var moreButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        btn.setTitle(String.fontAwesomeIcon("bars"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.tintColor = .gray
        btn.addTarget(self, action: #selector(moreBtn), for: .touchDown)
        return btn
    }()
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    //MARK:- Menu Slider Collection View
    //GOTO: setupCollectionViewSlider()
    
    lazy var collectionViewSlider: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
        cv.layer.opacity = 0
        return cv
    }()
    var cardButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.titleLabel?.font = UIFont.icon(from: .MaterialIcon, ofSize: 50)
        btn.setTitle(String.fontMaterialIcon("select.all"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.showsTouchWhenHighlighted = true
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.tintColor = .appGray
        btn.backgroundColor = .appColor
        btn.addTarget(self, action: #selector(cardBtn), for: .touchDown)
        return btn
    }()
    
    var delegate: HomeViewDelegate!
    let menus = MenuButtonCreator()
    
    
    //MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appGray
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTopContainer))
        topContainer.addGestureRecognizer(tap)
        
        
        registerCell()
    }
    //MARK:- Constaints
    var topContainerTopConstraint: NSLayoutConstraint!

    //MARK:- Setup Views
    func setupView(){

        addViews()
        setupTopContainer()
        setupLogoLabel()
        setupSearchTextField()
        setupSearchBtn()
        setupCategoryBtn()
        setupCollectionView()
        
        setupCardButton()
        
        //Menu Slider
        setupMoreButton()
        setupCollectionViewSlider()
        
        //Activity Indicator
        setupContainerView()
        setupActivityIndicator()
    }
    //MARK:- Add Sub Views
    func addViews(){
        addSubview(topContainer)
        addSubview(logoLabel)
        addSubview(searchTextField)
        addSubview(searchButton)
        addSubview(moreButton)
        addSubview(collectionViewSlider)
        addSubview(containerView)
        addSubview(activityIndicatorView)
        addSubview(cardButton)
        addSubview(categoryBtn)
        addSubview(collectionView)
    }
    
    //MARK:- TopContainer
    //Handle Animation
    func setupTopContainer(){
        topContainerTopConstraint = topContainer.topAnchor.constraint(equalTo: topAnchor)
        topContainerTopConstraint.isActive = true
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20)
            ])
    }
    func setupLogoLabel(){
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 70),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    func setupSearchTextField(){
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    func setupSearchBtn(){
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 25),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }
    func setupCategoryBtn(){
        NSLayoutConstraint.activate([
            categoryBtn.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 10),
            categoryBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryBtn.heightAnchor.constraint(equalTo: categoryBtn.heightAnchor),
            ])
    }
    func setupCollectionView(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categoryBtn.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        sendSubview(toBack: collectionView)
    }
    func setupCardButton(){
        NSLayoutConstraint.activate([
            cardButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cardButton.heightAnchor.constraint(equalToConstant: 60),
            cardButton.widthAnchor.constraint(equalToConstant: 60),
            cardButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            ])
    }
    
    //MARK:- Cool Menu Button
    func setupMoreButton(){
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            moreButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            moreButton.heightAnchor.constraint(equalToConstant: 40),
            moreButton.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    //MARK:- Cool Menu Animate Collection View
    func setupCollectionViewSlider(){
        NSLayoutConstraint.activate([
            collectionViewSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            collectionViewSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewSlider.topAnchor.constraint(equalTo: topAnchor),
            collectionViewSlider.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    func setupContainerView(){
        //this is to block user while search button is touched...
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        containerView.isHidden = true
    }
    func setupActivityIndicator(){
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 40),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- Getters & Setters
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
    public var topContainerConstant: CGFloat {
        get {
            return topContainerTopConstraint.constant
        }
        set {
            topContainerTopConstraint.constant = newValue
        }
    }
    public var collectionViewSliderOpacity: Float {
        get {
            return collectionViewSlider.layer.opacity
        }
        set {
            collectionViewSlider.layer.opacity = newValue
        }
    }
}

//MARK:- Delegate Actions
extension HomeView {
    @objc fileprivate func searchBtn() {
        delegate.handleSearch()
    }
    @objc fileprivate func moreBtn() {
        delegate.handleMoreButton()
    }
    @objc fileprivate func cardBtn() {
        delegate.handleCard()
    }
    @objc fileprivate func moreCategoryBtn() {
        delegate.handleMoreCategory()
    }
    @objc fileprivate func tapTopContainer() {
        delegate.handleTapTopContainer()
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
    var menuSliderDelegate: UICollectionViewDelegate? {
        get {
            return collectionViewSlider.delegate
        }
        set {
            collectionViewSlider.delegate = newValue
        }
    }
    var menuSliderDataSource: UICollectionViewDataSource? {
        get {
            return collectionViewSlider.dataSource
        }
        set {
            collectionViewSlider.dataSource = newValue
        }
    }
}



