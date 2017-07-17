//
//  csCustomFuctions.swift
//  EasyLearn
//
//  Created by Tebeen on 4/12/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardSettingsController {
    //MARK:- Custom Fuctions
    func pushViewController(_ controller: UIViewController){
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func handlePlaySpeedSlider(_ cell: UITableViewCell){
        let slider = createSpeedSlider(cell)
        cell.textLabel?.text = nil
        cell.contentView.addSubview(slider)
        cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "tune", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
        cell.selectionStyle = .none
    }
    
    func createSpeedSlider(_ cell: UITableViewCell) -> UISlider {
        let slider = UISlider()
        slider.bounds = CGRect(x: 0, y: 0, width: Int(cell.contentView.bounds.width - 63), height: Int(slider.bounds.height))
        slider.center = CGPoint(x: cell.contentView.center.x + 20, y: cell.contentView.center.y)
        slider.minimumValue = 1 //very fast
        slider.maximumValue = 10 //very slow
        slider.isContinuous = true
        slider.value = UserDefaults.standard.float(forKey: UserDefaultsKeys.cardSpeedValue.rawValue)
        handleSpeedSliderControl(slider: slider) //initial value
        slider.addTarget(self, action: #selector(handleSpeedSliderControl(slider:)), for: .valueChanged)
        
        //layers
        slider.minimumTrackTintColor = .appColor
        return slider
    }
    
    func handleSpeedSliderControl(slider: UISlider){
        slider.setThumbImage(progressImage(with: Int16(slider.value), color: .appColor, textColor: .black), for: .normal)
        UserDefaults.standard.set(slider.value, forKey: "cardSpeedValue")
        UserDefaults.standard.synchronize()
    }
    
    func handleCardHidden(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        let uiSwitch = UISwitch(frame: .zero)
        
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage.icon(from: .MapIcon, code: "map.icon.pharmacy", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
            uiSwitch.tag = 100
            uiSwitch.isOn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.cardNumberLabel.rawValue)
//        case 1:
//            cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "check.circle", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
//            uiSwitch.tag = 200
        default:
            break
        }
        
        cell.selectionStyle = .none
        cell.accessoryView = uiSwitch
        
        uiSwitch.addTarget(self, action: #selector(handleCardNumberHide(uiSwitch:)), for: UIControlEvents.valueChanged)
    }
    
    func handleCardNumberHide(uiSwitch: UISwitch){
        if uiSwitch.tag == 100 {
            //hide the card number label
            UserDefaults.standard.set(uiSwitch.isOn, forKey: UserDefaultsKeys.cardNumberLabel.rawValue)
            UserDefaults.standard.synchronize()
            uiSwitch.isOn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.cardNumberLabel.rawValue)
        } else if uiSwitch.tag == 200 {
            print(200)
        }
    }
    
    func handleColors(_ cell: UITableViewCell, _ indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "colorize", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
        case 1:
            cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "color.lens", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
        default:
            break
        }
        cell.accessoryType = .disclosureIndicator
    }
    
    func handleFlippingStyle(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        cell.imageView?.image = UIImage.icon(from: .MaterialIcon, code: "flip", imageSize: CGSize(width: 25, height: 25), ofSize: 25, color: .appColor)
        cell.accessoryType = .disclosureIndicator
    }
}
