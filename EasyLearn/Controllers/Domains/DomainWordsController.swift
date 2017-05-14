//
//  DomainWordsController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class DomainWordsController: UITableViewControllerWithViews {
    
    var domain: Domain!
    
    var words: [Word]?
    
    var cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        handleNavigationBar()
    }
    func handleNavigationBar() {
        navigationItem.title = domain.name
    }
    
    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = words?.count {
            return count
        }
        
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = words?[indexPath.row].word
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let text = words?[indexPath.item].id
        
        
        if Reachability.isConnectedToNetwork {
            let web = WebService(text!, filters: [.lexicalCategory])
            
            
            web.get { (word, status) in
                let lexicalEntryVC = LexicalEntryViewController()
                lexicalEntryVC.word = word
                self.navigationController?.pushViewController(lexicalEntryVC, animated: true)
            }
            if web.request != nil {
                //homeView.containerView.isHidden = false
                activityIndicatorView.startAnimating()
            }
            
            
        } else {
            noInternetAlert(self)
        }
        
    }
}



