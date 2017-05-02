//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordSubDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var wordDetail: Detail?
    
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
        //navigationItem.title = word?.word
        setupView()
        registerCells()
    }
    //MARK:- Register Cells and Setup Views
    func registerCells(){
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wsdCellID.rawValue)
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
        if let count = wordDetail?.subDetails?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wsdCellID.rawValue, for: indexPath) as! DetailsCell
        //cell.backgroundColor = .blue
        
        
        if let formatedString = formatedStringForTextAt(indexPath) {
            cell.numberCircle.text = "\(indexPath.item+1)"
            cell.textView.attributedText = formatedString
        }
        
        
        cell.didTapBookmark = {
            //print(self.word?.details?[indexPath.item].definition)
            print("sub details")
        }
        
        cell.btnMoreDetails.isHidden = true
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //give a very large height
        
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        if let formatedString = formatedStringForTextAt(indexPath) {
            let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
            return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
        }
        return size
        
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(word?.details?[indexPath.item].subdetails?[indexPath.item].subDefinition)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //MARK:- Custom Functions
    
    func formatedStringForTextAt(_ indexPath: IndexPath) -> NSMutableAttributedString? {
        
        guard let definition = wordDetail?.subDetails?[indexPath.item].subDefinition, let examples = wordDetail?.subDetails?[indexPath.item].subExamples else { return nil}
        
        
        let result = wdDefinition(definition)
        if let text = wdExample(examples) {
            result.append(text)
        }
        
        if let text = wordDetail?.subDetails?[indexPath.item].subRegister {
            let register = wdRegister(text)
            result.insert(register, at: 0)
            
        }
        
        return result
    }
    
    //Word Definition
    func wdDefinition(_ definition: String) -> NSMutableAttributedString {
        let defAttributedText = NSMutableAttributedString(string: "\(definition)\n", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
        return defAttributedText
    }
    //Word Example (not working now)
    func wdExample(_ examples: [String]) -> NSMutableAttributedString? {
        for element in examples {
            let exampleAttributedText = NSMutableAttributedString(string: "\n• \(element.capitalizingFirstLetter())", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
            return exampleAttributedText
        }
        return nil
    }
    //Word Register
    func wdRegister(_ register: String) -> NSMutableAttributedString {
        let registerAttrText = NSMutableAttributedString(string: "(\(register)) ", attributes: [NSFontAttributeName:UIFont(name: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
        return registerAttrText
    }
    
}




















