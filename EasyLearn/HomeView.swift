//
//  HomeView.swift
//  EasyLearn
//
//  Created by Tebeen on 3/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

protocol HandleSearchDelegate {
    func handleSearch()
}

class HomeView: UIView {
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
    var searchButtonView: UIView = {
        //put an icon as an image here.
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var searchButtonLabel: UILabel = {
        //put an icon as an image here.
        let label = UILabel()
        label.font = UIFont.icon(from: .FontAwesome, ofSize: 20)
        label.text = String.fontAwesomeIcon("search")
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        //cv.dataSource = self
        //cv.delegate = self
        return cv
    }()
    
    
    //MARK:- Setup Views
    func setupView(){
        
        addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(searchTextField)
        addSubview(searchButtonView)
        
        searchTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchButtonView.trailingAnchor, constant: 0).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchButtonView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25).isActive = true
        searchButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        searchButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButtonView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        searchButtonView.addSubview(searchButtonLabel)
        searchButtonLabel.centerXAnchor.constraint(equalTo: searchButtonView.centerXAnchor).isActive = true
        searchButtonLabel.centerYAnchor.constraint(equalTo: searchButtonView.centerYAnchor).isActive = true
        
        
        
    }
    
     
    

}
