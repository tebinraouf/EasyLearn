//
//  LoginView.swift
//  EasyLearn
//
//  Created by Tebeen on 5/24/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class LoginView: UIScrollView {
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
        btn.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("forget password?", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
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
    //MARK:- Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        
        
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
        loginRegisterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -220).isActive = true
    }
    func keyboardResponder() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    var loginDelegate: LoginViewDelegate!
    //MARK: Button Handlers
    @objc private func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            handleLogin()
        }else{
            handleRegister()
        }
    }
    private func handleLogin(){
        loginDelegate.loginBtn()
    }
    private func handleRegister(){
        loginDelegate.registerBtn()
    }
    @objc private func handleForgetPassword(){
        loginDelegate.forgetPasswordBtn()
    }
    
}



protocol LoginViewDelegate {
    func loginBtn()
    func registerBtn()
    func forgetPasswordBtn()
}

