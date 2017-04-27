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
    let cellID = "cellID"
    var didSelect: (Word?, String?) -> () = { _ in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        isNavBarHidden(false, navigationController)
        
        let _ = ShowDetails(nav: navigationController)
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
        didSelect(word, selectedWord)
    }
}


class ShowDetails {
    var navigationController: UINavigationController?
    var controller: LexicalEntryViewController
    
    init(nav: UINavigationController?) {
        self.navigationController = nav
        controller = navigationController?.topViewController as! LexicalEntryViewController
        controller.didSelect = showWord
    }
    func showWord(word: Word?, selectedWord: String?) {
        Service.sharedInstance.detailsFor(word:  (word?.word!)!, lexicalCategory: selectedWord!) { (details, error) in
            if error == nil {
                
                word?.details = details
                
                let detailsViewController = WordDetailsVC()
                detailsViewController.word = word
                detailsViewController.lexicalCategory = selectedWord
                
                let navController = UINavigationController(rootViewController: detailsViewController)
                
                detailsViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelPresentViewController))
            
                self.controller.present(navController, animated: true, completion: nil)
            }
        }
    }
    @objc func cancelPresentViewController(){
        controller.dismiss(animated: true, completion: nil)
    }
    
}




