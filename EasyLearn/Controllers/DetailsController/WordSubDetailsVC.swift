//
//  WordDetailsViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation

class WordSubDetailsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var wordDetail: Detail?
    
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        collectionViewSetup()
    }
    //MARK:- CollectionView Usual Setup
    func collectionViewSetup(){
        collectionView?.register(DetailsCell.self, forCellWithReuseIdentifier: CellID.wsdCellID.rawValue)
        collectionView?.backgroundColor = .appGray
    }
    //MARK:- Collection View Functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = wordDetail?.subDetailsCount.flatMap({ $0 }) {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wsdCellID.rawValue, for: indexPath) as! DetailsCell
        //cell.backgroundColor = .blue
        
        let generator = DataGenerator(wordDetail!, indexPath)
        let cellData = DetailCellData(generator, cell)
        cellData.populateCell()
        
    
        
        
        let interaction = UserInteraction(target: self, wordDetail!, cell, indexPath)
        interaction.didInteract()
        
        
        
        //Use Protocol
        //        let generator = DataGenerator(wordDetail!, indexPath)
        //        let cellData = DetailCellData(generator, cell)
        //        cellData.populateCell()
        //
        //
        //        let interaction = UserInteraction(target: self, wordDetail!, cell, indexPath)
        //        interaction.didInteract()
        //
        //
        
        //
        //        if let formatedString = formatedStringForTextAt(indexPath) {
        //            cell.numberCircle.text = "\(indexPath.item+1)"
        //            cell.textView.attributedText = formatedString
        //        }
        //
        //
        //        cell.didTapBookmark = {
        //            //print(self.word?.details?[indexPath.item].definition)
        //            print("sub details")
        //        }
        //
        //        cell.btnMoreDetails.isHidden = true
        //
        //
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
        collectionView?.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(word?.details?[indexPath.item].subdetails?[indexPath.item].subDefinition)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top: CGFloat = DeviceState.isPortrait.state ? 64 : 35
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
        return collectionView.scrollIndicatorInsets
    }
    
    
    //MARK:- Custom Functions
    func formatedStringForTextAt(_ indexPath: IndexPath) -> NSMutableAttributedString? {
        
        guard let definition = wordDetail?.details?[indexPath.item].definition, let examples = wordDetail?.details?[indexPath.item].examples else { return nil}
        
        
        let result = wdDefinition(definition)
        if let text = wdExample(examples) {
            result.append(text)
        }
        
        if let text = wordDetail?.details?[indexPath.item].register {
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





















