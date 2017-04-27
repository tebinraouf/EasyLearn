//
//  LexicalEntryViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/6/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
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



class LexicalEntryViewController: UITableViewController {
    var word: Word?
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        isNavBarHidden(false, navigationController)
    }
    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = word?.lexicalCount {
            return count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let cellData = CellData(word, cell, indexPath)
        cellData.setCellValue()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = word?.lexicalEntries?[indexPath.row]
        Service.sharedInstance.detailsFor(word:  (word?.word!)!, lexicalCategory: selectedWord!) { (details, error) in
            if error == nil {
                self.word?.details = details
                let detailsViewController = WordDetailsVC()
                detailsViewController.word = self.word
                detailsViewController.lexicalCategory = selectedWord
                let navController = UINavigationController(rootViewController: detailsViewController)
                detailsViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelPresentViewController))
                self.present(navController, animated: true, completion: nil)
            }
        }
    }
    func cancelPresentViewController(){
        self.dismiss(animated: true, completion: nil)
    }
}





