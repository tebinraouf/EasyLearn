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
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 1:
            count = 2
        case 2:
            count = 2
        default:
            count = 1
        }
        
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        
        
        
        let uiSwitch = UISwitch(frame: .zero)
        
        
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Card play speed"
            cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "tune", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
            cell.accessoryType = .disclosureIndicator
        case 1:
            
            switch indexPath.row {
            case 0:
                
                cell.textLabel?.text = "Card number - total"
                cell.imageView?.image = UIImage.icon(from: .MapIcon, code: "map.icon.pharmacy", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
                uiSwitch.tag = 100
            case 1:
                cell.textLabel?.text = "Card check cirlce"
                cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "check.circle", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
                uiSwitch.tag = 200
            default:
                break
            }
            
            cell.selectionStyle = .none
            cell.accessoryView = uiSwitch
            
        case 2:
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Card background color"
                cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "format.color.fill", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
            case 1:
                cell.textLabel?.text = "Card text color"
                cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "format.color.text", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
            default:
                break
            }
            
            cell.accessoryType = .disclosureIndicator
            
        default:
            break
            
            
            
        }
        
        uiSwitch.addTarget(self, action: #selector(handleCardNumberHide(uiSwitch:)), for: UIControlEvents.valueChanged)

        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var header = ""
        switch section {
        case 0:
            header = sections[0]
        case 1:
            header = sections[1]
        case 2:
            header = sections[2]
        case 3:
            header = sections[3]
        case 4:
            header = sections[4]
        default:
            header = ""
        }
        
        return header
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            pushViewController(PlaySpeedController())
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
    
    
    func pushViewController(_ controller: UIViewController){
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func handleCardNumberHide(uiSwitch: UISwitch){
        
        if uiSwitch.tag == 100 {
            print(100)
        } else if uiSwitch.tag == 200 {
            print(200)
        }
        
        
    }

}
