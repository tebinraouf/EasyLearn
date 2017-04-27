//
//  CellData.swift
//  EasyLearn
//
//  Created by Tebeen on 4/27/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CellData {
    private var word: Word?
    private var cell: UITableViewCell
    private var indexPath: IndexPath
    public init(_ word: Word?, _ cell: UITableViewCell, _ indexPath: IndexPath) {
        self.word = word
        self.cell = cell
        self.indexPath = indexPath
    }
    private func getFormattedWord() -> NSAttributedString? {
        if let word = word, let wordName = word.word, let entries = word.lexicalEntries {
            
            let wordNameString = mainText(wordName)
            let entryString = lexicalCategoryString(entries)
            
            //Space
            let custom03 = CustomAttributtedString(text: " ")
            let space = custom03.getAttributtedString()
            
            wordNameString.append(space)
            wordNameString.append(entryString)
            return wordNameString
        }
        return nil
    }
    private func mainText(_ text: String) -> NSMutableAttributedString{
        let custom01 = CustomAttributtedString(text: text)
        return custom01.getAttributtedString()
    }
    private func lexicalCategoryString(_ entries: [String]) -> NSMutableAttributedString {
        //Lexical Category
        let entry = entries[indexPath.row]
        let custom02 = CustomAttributtedString(text: entry)
        custom02.size = custom02.size - 2
        custom02.color = .appColor
        custom02.font = UIFont.italicSystemFont(ofSize: custom02.size)
        return custom02.getAttributtedString()
    }
    func setCellValue() {
        cell.textLabel?.attributedText = getFormattedWord()
    }
}

