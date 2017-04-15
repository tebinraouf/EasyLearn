//
//  CardBgColorController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardBgColorController: UIViewController {
    
    
    var alpha: CGFloat = 1
    
    let colorView = BackgroundColorView()
    
    let bgLayer = CAShapeLayer()
    let bgColor = UIColor.appGray
    
    let fgLayer = CAShapeLayer()
    let fgColor = UIColor.black
    
    
    let userSettings = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleRandomColor()
        
    }
    
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupShapeLayer(shapeLayer: bgLayer)
        setupShapeLayer(shapeLayer: fgLayer)
        colorView.alphaLabel.text = String(format: "%1.2f", alpha)
    }
    
    func setupShapeLayer(shapeLayer: CAShapeLayer){
        shapeLayer.frame = view.bounds
        let startAngle = DegreesToRadians(135.0)
        let endAngle = DegreesToRadians(45.0)
        let center = view.center
        let radius: CGFloat = 80
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.cgPath
    }
    func DegreesToRadians (_ value:CGFloat) -> CGFloat {
        return value * CGFloat(Double.pi) / 180.0
    }
    
    //not seeing the effect!
    func animate(fromValue: Float, toValue: Float) {
        //let toValue: Float = 0
        
        // 1
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromValue
        animation.toValue = toValue
        // 2
        bgLayer.removeAnimation(forKey: "opacityKey")
        bgLayer.add(animation, forKey: "opacityKey")
        
        fgLayer.removeAnimation(forKey: "opacityKey2")
        fgLayer.add(animation, forKey: "opacityKey2")
        
        bgLayer.opacity = toValue
        fgLayer.opacity = toValue
    }
    
    func setUserSettings(for value: Float, forKey: String) {
        userSettings.setValue(value, forKey: forKey)
        userSettings.synchronize()
    }

    
        
    
    
    
}





