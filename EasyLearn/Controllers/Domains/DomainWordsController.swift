//
//  DomainWordsController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class DomainWordsController: UITableViewController {
    
    var domain: String!
    
    
    var cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        handleNavigationBar()
    }
    func handleNavigationBar() {
        navigationItem.title = domain
    }
    
    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        //cell.textLabel?.text = domains[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
