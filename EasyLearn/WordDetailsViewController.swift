//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var word: Word?
    let cellID = "cellID"
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .appGray
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        navigationItem.title = word?.word
        setupView()
        registerCells()
        
        
    }
    //MARK:- Register Cells and Setup Views
    func registerCells(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: cellID)
    }
    func setupView(){
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    //MARK:- Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = word?.details?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailsCell
        //cell.backgroundColor = .blue
    
        
        if let formatedString = formatedStringForTextAt(indexPath) {
            cell.numberCircle.text = "\(indexPath.item+1)"
            cell.textView.attributedText = formatedString
        }
        
        cell.completion = {
            print(self.word?.details?[indexPath.item].definition)
            print(1223)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //give a very large height
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        if let formatedString = formatedStringForTextAt(indexPath) {
            let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
            return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 35)
        }
        return size
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //MARK:- Custom Functions
    func formatedStringForTextAt(_ indexPath: IndexPath) -> NSMutableAttributedString? {
        guard let definition = word?.details?[indexPath.item].definition, let examples = word?.details?[indexPath.item].examples else { return nil}
        
        let defAttributedText = NSMutableAttributedString(string: "\(definition)\n", attributes: nil)
        var exampleAttributedText: NSMutableAttributedString?
        for element in examples {
            exampleAttributedText = NSMutableAttributedString(string: "\n• \(element.capitalizingFirstLetter())", attributes: nil)
            defAttributedText.append(exampleAttributedText!)
        }
        return defAttributedText
    }
    
    func createBullet(){
        let text = ""
    }
}





















