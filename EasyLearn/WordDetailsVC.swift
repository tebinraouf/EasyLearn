//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordDetailsVC: UIViewController {
    //MARK:- Variables
    var word: Word?
    
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
        collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wdCellID.rawValue)
    }
    
    //MARK:- Custom Functions
    func formatedStringForTextAt(_ indexPath: IndexPath) -> NSMutableAttributedString? {
        guard let definition = word?.details?[indexPath.item].definition, let examples = word?.details?[indexPath.item].examples else { return nil }
        
        let result = wdDefinition(definition)
        if let text = wdExample(examples) {
            result.append(text)
        }
        
        if let register = word?.details?[indexPath.item].register {
            result.insert(wdRegister(register), at: 0)
        }
        
        return result
    }
    

    //Word Definition
    func wdDefinition(_ definition: String) -> NSMutableAttributedString {
        let defAttributedText = NSMutableAttributedString(string: "\(definition)\n", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
        return defAttributedText
    }
    //Word Example
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





















