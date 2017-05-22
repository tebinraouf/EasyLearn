//
//  PageView.swift
//  EasyLearn
//
//  Created by Tebeen on 5/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

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
        //btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
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
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200)
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
    
    
    
    var centerConstraint: NSLayoutConstraint!
    func setupLoginView() {
        let top = loginView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10)
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
    }
}


extension PageView {
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
}

class LoginView: UIView {
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Sign In", "Register"])
        //sc.backgroundColor = .white
        sc.tintColor = .white
        sc.selectedSegmentIndex = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: UIControlEvents.valueChanged)
        return sc
    }()
    let container: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    let nameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.placeholder = "enter name"
        return textField
    }()
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.placeholder = "enter email address"
        textField.keyboardType = .emailAddress
        return textField
    }()
    let passTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter password"
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var loginRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor.appColor, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20

        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = .zero
        btn.layer.shadowOpacity = 0.5
        btn.layer.shouldRasterize = true //cache the shadow because it's expensive
        //button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("forget password?", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        //button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return btn
    }()
    
    let fieldHeight: CGFloat = 40
    let containerHeight: CGFloat = 40 * 3 + 30
    let containerHeightWithoutName: CGFloat = 40 * 3
    
    var containerConstraint: NSLayoutConstraint!
    var nameHeightConstraint: NSLayoutConstraint!
    var nameTopConstarint: NSLayoutConstraint!
    
    func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        

        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            nameTopConstarint.constant = 0
            nameTextField.isHidden = true
            forgetPasswordBtn.isHidden = false

           
        } else {
            nameTopConstarint.constant = 10
            nameTextField.isHidden = false
            forgetPasswordBtn.isHidden = true
            
        }
        
        containerConstraint.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? containerHeightWithoutName : containerHeight

        nameHeightConstraint.isActive = false
        let nameHeight: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : (1/3 - 0.06)
        nameHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: nameHeight)
        nameHeightConstraint.isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubViews()
        setupSegmentedControl()
        setupContainer()
        setupForgetPassword()
        setupLoginRegisterBtn()
    }
    func addSubViews(){
        addSubview(loginRegisterSegmentedControl)
        addSubview(container)
        container.addSubview(nameTextField)
        container.addSubview(emailTextField)
        container.addSubview(passTextField)
        addSubview(forgetPasswordBtn)
        addSubview(loginRegisterButton)
    }
    func setupSegmentedControl(){
        NSLayoutConstraint.activate([
            loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginRegisterSegmentedControl.topAnchor.constraint(equalTo: topAnchor),
            loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: fieldHeight),
            loginRegisterSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            loginRegisterSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    func setupContainer(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        //height = name + email + password + spacing height
        containerConstraint = container.heightAnchor.constraint(equalToConstant: fieldHeight * 3 + 30)
        containerConstraint.isActive = true
        
        setupName()
        setupEmail()
        setupPassword()
    }
    func setupName(){
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            ])

        nameTopConstarint = nameTextField.topAnchor.constraint(equalTo: container.topAnchor)
        nameTopConstarint.constant = 10
        nameTopConstarint.isActive = true
        
        nameHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1/3 - 0.06)
        nameHeightConstraint.isActive = true
    }
    func setupEmail(){
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    func setupPassword(){
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            passTextField.heightAnchor.constraint(equalToConstant: fieldHeight)
            ])
    }
    func setupForgetPassword(){
        forgetPasswordBtn.topAnchor.constraint(equalTo: passTextField.bottomAnchor).isActive = true
        forgetPasswordBtn.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        forgetPasswordBtn.heightAnchor.constraint(equalTo: forgetPasswordBtn.heightAnchor).isActive = true
        forgetPasswordBtn.widthAnchor.constraint(equalTo: forgetPasswordBtn.widthAnchor).isActive = true
        forgetPasswordBtn.isHidden = true
    }
    
    
    func setupLoginRegisterBtn(){
        loginRegisterButton.topAnchor.constraint(equalTo: forgetPasswordBtn.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: fieldHeight).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    
    
}






