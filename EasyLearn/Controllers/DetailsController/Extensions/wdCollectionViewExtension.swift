//
//  wordDetailsCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 3/23/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension WordDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = word?.details?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.wdCellID.rawValue, for: indexPath) as! DetailsCell
        
        let generator = DataGenerator(word!, indexPath)
        let cellData = DetailCellData(generator, cell)
        cellData.populateCell()
        
        
        let interaction = UserInteraction(word!, cell, indexPath)
        interaction.didInteract()
        
        //handleAddingWord(cell, indexPath)
        handleMoreDetails(cell, indexPath)
        subWordContents(cell, indexPath)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        let generator = DataGenerator(word!, indexPath)
        let formatedString = generator.cellText
        let estimatedFrame = formatedString.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 60)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}



struct UserInteraction {
    private var word: Word
    private var cell: DetailsCell
    private var indexPath: IndexPath
    
    public init(_ word: Word, _ cell: DetailsCell, _ indexPath: IndexPath) {
        self.word = word
        self.cell = cell
        self.indexPath = indexPath
    }
    public func didInteract() {
        cell.didTapBookmark = didTapBookmark
    }
    
    private func didTapBookmark() {
        print("Tap Tap...")
    }
}

struct DetailCellData {
    private var cell: DetailsCell
    private var data: DataGenerator
    
    public init(_ data: DataGenerator, _ cell: DetailsCell) {
        self.data = data
        self.cell = cell
        
    }
    public func populateCell() {
        cell.textViewText = data.cellText
        cell.cellNumberText = data.cellNumber
        cell.bookmarkIconText = data.bookmarkText
    }
    
}


struct DataGenerator {
    private var indexPath: IndexPath
    private var word: Word
    private var coreData: DataLayerSimple

    public init(_ word: Word, _ indexPath: IndexPath) {
        self.word = word
        self.indexPath = indexPath
        coreData = DataLayerSimple()
    }
    public func getRegister() -> String {
        if let register = word.details?[indexPath.item].register {
            return "(\(register)) "
        }
        return ""
    }
    public func getDefinition() -> String {
        if let def = word.details?[indexPath.item].definition {
            return "\(def)\n"
        }
        return ""
    }
    public func getExample() -> String {
        if let examples = word.details?[indexPath.item].examples {
            var elements = String()
            for element in examples {
                elements.append("\n• \(element.capitalizingFirstLetter())")
            }
            return elements
        }
        return ""
    }
    //Computed Properties
    public var cellText: NSMutableAttributedString {
        
        let textFormatter = TextFormatter()
        
        textFormatter.setText(getRegister())
        let formatter = textFormatter.getAttributtedStringFor(textFormatter.getText())
        formatter.obj.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        textFormatter.append(formatter.obj.getAttributtedString())
        
        
        textFormatter.append(getDefinition())
        textFormatter.append(getExample())
        
        return textFormatter.combinedText()
    }
    public var cellNumber: String {
        return "\(indexPath.item + 1)"
    }
    public var bookmarkText: String {
        if let wordID = word.details?[indexPath.item].wordId {
            let isWord = coreData.isWordSavedWith(id: wordID)
            if isWord {
                return String.fontAwesomeIcon("bookmark")!
            } else {
                return String.fontAwesomeIcon("bookmark-o")!
            }
        }
        return ""
    }
    
}
class TextFormatter {
    private var text: String = ""
    private var texts: NSMutableAttributedString
    
    public init() {
        texts = NSMutableAttributedString()
    }
    public func combinedText() -> NSMutableAttributedString {
        return texts
    }
    public func append(_ text: String) {
        texts.append(getAttributtedStringFor(text).attr)
    }
    public func append(_ attrText: NSAttributedString) {
        texts.append(attrText)
    }
    public func setText(_ text: String) {
        self.text = text
    }
    public func getText() -> String {
        return text
    }
    public func getAttributtedStringFor(_ text: String) -> (obj: CustomAttributtedString, attr: NSMutableAttributedString) {
        let custom00 = CustomAttributtedString(text: text)
        let mainAttributtedString = custom00.getAttributtedString()
        return (obj: custom00, attr: mainAttributtedString)
    }
}


