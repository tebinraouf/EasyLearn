//
//  wdCustomFuncs.swift
//  EasyLearn
//
//  Created by Tebeen on 4/24/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

//custom funcs
extension WordDetailsVC {
    func handleAddingWord(_ cell: DetailsCell, _ indexPath: IndexPath){
        cell.didTapBookmark = {
            let id = self.word?.details?[indexPath.item].wordId
            let language = self.word?.language
            let lexicalEntry = self.lexicalCategory
            let word = self.word?.word
            let type = self.word?.type
            let examples = self.word?.details?[indexPath.item].examples
            let definition = self.word?.details?[indexPath.item].definition
            
            let wordID = self.word?.getWordID(at: indexPath)
            
            let isWord = self.currentDataLayer.isWordSavedWith(id: wordID!)
            if isWord {
                cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark-o"), for: .normal)
                self.currentDataLayer.removeWordBy(id: wordID!)
            } else {
                cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark"), for: .normal)
                self.currentDataLayer.saveWord(id, language, lexicalEntry, word, type, examples, definition)
            }
        }
    }
    func handleMoreDetails(_ cell: DetailsCell, _ indexPath: IndexPath) {
        if word?.details?[indexPath.item].subDetails?.count == 0 {
            cell.btnMoreDetails.isHidden = true
            
        } else {
            cell.btnMoreDetails.isHidden = false
        }
    }
    func subWordContents(_ cell: DetailsCell, _ indexPath: IndexPath){
        cell.handleSubWordDetailsFunc = {
            let subDetailsController = WordSubDetailsVC()
            subDetailsController.wdDelegate = self
            subDetailsController.wordDetail = self.word?.details?[indexPath.item]
            self.navigationController?.pushViewController(subDetailsController, animated: true)
        }
    }
}
