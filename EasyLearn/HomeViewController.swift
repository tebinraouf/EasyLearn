//
//  ViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import SwiftIconFont


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"

    var logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.backgroundColor = .appColor
        iv.layer.cornerRadius = 100
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    var searchTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        registerCells()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSearch))
        searchButtonView.addGestureRecognizer(tap)
        
        navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    func handleSearch(){
        if let text = searchTextField.text {
            Service.sharedInstance.initialSearch(word: text, completion: { (word, error) in
                let lexicalEntryVC = LexicalEntryViewController()
                lexicalEntryVC.delegate = self
                lexicalEntryVC.word = word
                self.navigationController?.pushViewController(lexicalEntryVC, animated: true)
                //present(lexicalEntryVC, animated: true, completion: nil)
            })
        }
    }

    func registerCells(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    
    //MARK:- Setup Views
    func setupView(){
        
        view.addSubview(logoImage)
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(searchTextField)
        view.addSubview(searchButtonView)
        
        searchTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: searchButtonView.trailingAnchor, constant: 0).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        searchButtonView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 25).isActive = true
        searchButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButtonView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        
        
        searchButtonView.addSubview(searchButtonLabel)
        searchButtonLabel.centerXAnchor.constraint(equalTo: searchButtonView.centerXAnchor).isActive = true
        searchButtonLabel.centerYAnchor.constraint(equalTo: searchButtonView.centerYAnchor).isActive = true
        
        
        
    }
    
    
    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.height/2 - 10)
        return size
    }
    
    
    
    
    
    
    
    
    
}


class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
