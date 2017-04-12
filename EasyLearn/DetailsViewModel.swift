//
//  DetailsViewModel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/10/17.
//  Copyright © 2017 Tebin. All rights reserved.
//
//MVVM
import UIKit

struct DetailsViewModel {
    let textView: NSAttributedString
    let numberCircle: String
    
    
    
    init(word: Word?, indexPath: IndexPath) {
        
    
        //definition
        let result = NSMutableAttributedString()
        
        if let def = word?.details?[indexPath.item].definition {
            result.append(DetailsViewModel.wdDefinition(def))
        }
        
        if let examples = word?.details?[indexPath.item].examples {
            //examples
            for element in examples {
                let exampleAttributedText = NSMutableAttributedString(string: "\n• \(element.capitalizingFirstLetter())", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
                result.append(exampleAttributedText)
            }
        }
        
        //register
        if let register = word?.details?[indexPath.item].register {
            result.insert(DetailsViewModel.wdRegister(register), at: 0)
        }
        
        
        self.textView = result
        self.numberCircle = "\(indexPath.item+1)"
    }
    
    func getFormatedString() -> NSAttributedString {
        return self.textView
    }
    
    
    //Word Definition
    private static func wdDefinition(_ definition: String) -> NSMutableAttributedString {
        let defAttributedText = NSMutableAttributedString(string: "\(definition)\n", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
        return defAttributedText
    }
    //Word Example (not working now)
    private static func wdExample(_ examples: [String]) -> NSMutableAttributedString? {
        for element in examples {
            let exampleAttributedText = NSMutableAttributedString(string: "\n• \(element.capitalizingFirstLetter())", attributes: [NSFontAttributeName:UIFont(name: UIFont.systemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
            return exampleAttributedText
        }
        return nil
    }
    //Word Register
    private static func wdRegister(_ register: String) -> NSMutableAttributedString {
        let registerAttrText = NSMutableAttributedString(string: "(\(register)) ", attributes: [NSFontAttributeName:UIFont(name: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize).fontName, size: UIFont.systemFontSize)!])
        return registerAttrText
    }
    
    
}
