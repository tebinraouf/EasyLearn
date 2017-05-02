//
//  UserInteraction.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

struct UserInteraction {
    private var word: Word
    private var cell: DetailsCell
    private var indexPath: IndexPath
    private var navigationController: UINavigationController?
    
    public init(target: UIViewController, _ word: Word, _ cell: DetailsCell, _ indexPath: IndexPath) {
        self.navigationController = target.navigationController
        self.word = word
        self.cell = cell
        self.indexPath = indexPath
    }
    public func didInteract() {
        cell.didTapBookmark = didTapBookmark
        cell.didTapMoreCell = didTapMoreCell
        isSubCellIcon()
    }
    private func didTapBookmark() {
        let language = self.word.language
        let lexicalEntry = self.word.lexicalEntry
        let word = self.word.word
        let type = self.word.type
        
        let id = self.word.getWordID(at: indexPath)
        let examples = self.word.getExamples(at: indexPath)
        let definition = self.word.getDefinition(at: indexPath)
        
        
        let coreData = DataLayerSimple()
        let isWord = coreData.isWordSavedWith(id: id!)
        if isWord {
            cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark-o"), for: .normal)
            coreData.removeWordBy(id: id!)
        } else {
            cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark"), for: .normal)
            coreData.saveWord(id, language, lexicalEntry, word, type, examples, definition)
        }
    }
    private func isSubCellIcon() {
        if word.getSubCount(at: indexPath) == 0 {
            cell.isMore = true
        } else {
            cell.isMore = false
        }
    }
    private func didTapMoreCell(){
        let subDetailsController = WordSubDetailsVC(collectionViewLayout: UICollectionViewFlowLayout())
        subDetailsController.wordDetail = self.word.getDetail(at: indexPath)
        navigationController?.pushViewController(subDetailsController, animated: true)
    }
    
}
