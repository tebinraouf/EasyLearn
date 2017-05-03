//
//  DataGenerator.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit



struct DataGenerator<T: WordPresentable> {
    var indexPath: IndexPath
    var word: T
    var coreData: DataLayerSimple
    
    public init(_ word: T, _ indexPath: IndexPath) {
        self.word = word
        self.indexPath = indexPath
        coreData = DataLayerSimple()
    }
    public func getRegister() -> String {

        if let register = word.getRegister(at: indexPath) {
            return "(\(register)) "
        }
        return ""
    }
    public func getDefinition() -> String {
        if let def = word.getDefinition(at: indexPath) {
            return "\(def)\n"
        }
        return ""
    }
    public func getExample() -> String {
        if let examples = word.getExamples(at: indexPath) {
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
        
        var textFormatter = TextFormatter()
        
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
        
        if let wordID = word.getWordID(at: indexPath) {
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

