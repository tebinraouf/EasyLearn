//
//  DomainViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation

//
//  LexicalEntryViewController.swift
//  EasyLearn
//
//  Created by Tebeen on 3/6/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class DomainController: UITableViewControllerWithViews {

    var domains: [CDDomain]!
    let domainCoreData = DomainCoreData()
    
    var cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        domains = domainCoreData.fetchAllDomains()
    }

    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domains.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = domains[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDomain = domains[indexPath.row]
        
        let domain = Domain(key: selectedDomain.key!, name: selectedDomain.name!)
        
        let domainWordsController = DomainWordsController()
        domainWordsController.domain = domain
       
        
        if Reachability.isConnectedToNetwork {
            let web = WebService(domain.key)
            web.getDomainWords { (words, status) in
                domainWordsController.words = words
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(domainWordsController, animated: true)
                }
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







