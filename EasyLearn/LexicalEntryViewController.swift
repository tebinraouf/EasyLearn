//
//  LexicalEntryViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/6/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class LexicalEntryViewController: UITableViewController {
    
    var word: Word?
    //var delegate: HomeViewController!
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
        if let count = word?.lexicalEntries?.count {
            return count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        
        
        if let word = word, let wordName = word.word, let entries = word.lexicalEntries {
            
            let wordFontSize = UIFont.systemFontSize
            let wordFont = UIFont.systemFont(ofSize: wordFontSize)
            let wordNameString = NSMutableAttributedString(string: wordName, attributes: [NSFontAttributeName:UIFont(name: wordFont.fontName, size: wordFontSize)!])
            
            let entry = entries[indexPath.row]
            let entryFontSize = UIFont.systemFontSize - 2
            let entryFont = UIFont.italicSystemFont(ofSize: entryFontSize)
            let formattedEntry = NSMutableAttributedString(
                
                string: entry, attributes:
                [
                    NSFontAttributeName:UIFont(name: entryFont.fontName, size: entryFontSize)!,
                    NSForegroundColorAttributeName:UIColor(cgColor: UIColor.appColor.cgColor)
                ])
            
            
            let attributedSpace = NSAttributedString(string: "  ")
            
            wordNameString.append(attributedSpace)
            wordNameString.append(formattedEntry)
            
            cell.textLabel?.attributedText = wordNameString
            
            
        }
        
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








