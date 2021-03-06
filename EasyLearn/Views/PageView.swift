//
//  PageView.swift
//  EasyLearn
//
//  Created by Tebeen on 5/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import FacebookLogin

class PageView: UIView {
    
    let cellID = "cellID"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        //cv.dataSource = self
        //cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
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
    var getStartedBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        //view.layer.ad
        return view
    }()
    var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("GET STARTED", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = .zero
        btn.layer.shadowOpacity = 0.5
        btn.layer.shouldRasterize = true //cache the shadow because it's expensive
        btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
        return btn
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 4 //self.pages.count + 1
        pc.currentPageIndicatorTintColor = .appColor
        return pc
    }()
    var getStartedConstraint: NSLayoutConstraint!
    var pageControlConstraint: NSLayoutConstraint!
    var loginView = LoginView()
    var facebookBtn: LoginButton = {
        let fb = LoginButton(readPermissions: [.publicProfile, .email])
        fb.translatesAutoresizingMaskIntoConstraints = false
        return fb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: CellID.pcCellID.rawValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addViews()
        logoLabelViewSetup()
        
        collectionViewSetup()
        setupGetStartedBackground()
        setupPageControl()
        setupGetStartedButton()
        setupFacebookButton()
        
        
        setupLoginView()
    }
    func logoLabelViewSetup(){
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoLabel.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    func collectionViewSetup(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    func setupGetStartedBackground(){
        NSLayoutConstraint.activate([
            getStartedBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            getStartedBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            getStartedBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            getStartedBackground.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    func setupGetStartedButton(){
        getStartedConstraint = getStartedButton.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        getStartedConstraint.isActive = true
        NSLayoutConstraint.activate(
            [getStartedButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
             getStartedButton.heightAnchor.constraint(equalTo: getStartedButton.heightAnchor),
             getStartedButton.widthAnchor.constraint(equalTo: getStartedButton.widthAnchor),
             ])
    }
    func setupPageControl(){
        pageControlConstraint = pageControl.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor)
        pageControlConstraint.isActive = true
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalTo: pageControl.heightAnchor),
            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            pageControl.topAnchor.constraint(equalTo: getStartedBackground.topAnchor, constant: 30)
            ])
    }
    var facebookCenterConstraint: NSLayoutConstraint!
    func setupFacebookButton(){
        //let top = facebookBtn.topAnchor.constraint(equalTo: getStartedBackground.topAnchor, constant: 10)
        let width = facebookBtn.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        let centerY = facebookBtn.centerYAnchor.constraint(equalTo: getStartedBackground.centerYAnchor)
        let height = facebookBtn.heightAnchor.constraint(equalToConstant: 40)
        facebookCenterConstraint = facebookBtn.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 400)
        facebookCenterConstraint.isActive = true
        NSLayoutConstraint.activate([width, centerY, height])
        
    }
    
    
    
    
    
    
    var centerConstraint: NSLayoutConstraint!
    func setupLoginView() {
        let top = loginView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor)
        //let leading = loginView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        //let trailing = loginView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        let width = loginView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        let bottom = loginView.bottomAnchor.constraint(equalTo: bottomAnchor)
        centerConstraint = loginView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 400)
        centerConstraint.isActive = true
        let constraints = [top, width, bottom]
        NSLayoutConstraint.activate(constraints)
    }
    func addViews(){
        addSubview(collectionView)
        addSubview(logoLabel)
        
        addSubview(loginView)
        
        addSubview(getStartedBackground)
        addSubview(pageControl)
        addSubview(getStartedButton)
        
        
        addSubview(facebookBtn)
        
    }
    func keyboardResponder(){
        loginView.keyboardResponder()
    }
    func setTextFieldsDelegate(_ delegate: UITextFieldDelegate?){
        loginView.nameTextField.delegate = delegate
        loginView.emailTextField.delegate = delegate
        loginView.passTextField.delegate = delegate
    }
    func updateConstraintFor(getStarted: CGFloat, pageControl: CGFloat, loginView: CGFloat, facebookBtn: CGFloat){
        getStartedConstantConstraint = getStarted
        pageControlConstantConstraint = pageControl
        loginViewConstantConstraint = loginView
        fbConstantConstraint = facebookBtn
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)

        
    }
    
    
    @objc private func handleGetStarted(){
        loginDelegate.getStartedBtn()
    }
    
    
}


extension PageView {
    var pageCollectionView: UICollectionView {
        get {
            return collectionView
        }
    }
    
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
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
    var getStartedConstantConstraint: CGFloat {
        get {
            return getStartedConstraint.constant
        }
        set {
            getStartedConstraint.constant = newValue
        }
    }
    var pageControlConstantConstraint: CGFloat {
        get {
            return pageControlConstraint.constant
        }
        set {
            pageControlConstraint.constant = newValue
        }
    }
    var loginViewConstantConstraint: CGFloat {
        get {
            return centerConstraint.constant
        }
        set {
            centerConstraint.constant = newValue
        }
    }
    var fbConstantConstraint: CGFloat {
        get {
            return facebookCenterConstraint.constant
        }
        set {
            facebookCenterConstraint.constant = newValue
        }
    }
    var loginName: String? {
        get {
            return loginView.nameTextField.text
        }
        set {
            loginView.nameTextField.text = newValue
        }
    }
    var loginEmail: String? {
        get {
            return loginView.emailTextField.text
        }
        set {
            loginView.emailTextField.text = newValue
        }
    }
    var loginPassword: String? {
        get {
            return loginView.passTextField.text
        }
        set {
            loginView.passTextField.text = newValue
        }
    }
    
    
    
    var loginDelegate: LoginViewDelegate {
        get {
            return loginView.loginDelegate
        }
        set {
            loginView.loginDelegate = newValue
        }
    }
    var facebookLoginDelegate: LoginButtonDelegate? {
        get {
            return facebookBtn.delegate
        }
        set {
            facebookBtn.delegate = newValue
        }
    }
}








