//
//  csCollectionViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardSettingsController: UITableViewDataSource, UITableViewDelegate {
    //MARK:- TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row]
        
        
        switch indexPath.section {
        case 0:
            handlePlaySpeedSlider(cell)
        case 1:
            handleCardHidden(cell, indexPath)
        case 2:
            handleColors(cell, indexPath)
        case 3:
            handleFlippingStyle(cell, indexPath)
        default: break
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            switch indexPath.row {
            case 0:
                pushViewController(CardBgColorController())
            default:
                break
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}




