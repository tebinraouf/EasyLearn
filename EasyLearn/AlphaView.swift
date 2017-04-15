//
//  AlphaView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class AlphaView: UIView {
    
    let bgLayer = CAShapeLayer()
    let bgColor = UIColor.appGray
    
    let fgLayer = CAShapeLayer()
    let fgColor = UIColor.black
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialCALayerSetups()
    }
    
    func setupShapeLayer(_ shapeLayer: CAShapeLayer){
        let startAngle = DegreesToRadians(135.0)
        let endAngle = DegreesToRadians(45.0)
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius: CGFloat = frame.size.width / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.cgPath
    }
    
    func initialCALayerSetups(){
        bgLayer.opacity = 0
        bgLayer.lineWidth = 10.0
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        bgLayer.strokeColor = bgColor.cgColor
        layer.addSublayer(bgLayer)
        
        fgLayer.opacity = 0
        fgLayer.lineWidth = 10.0
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 0
        fgLayer.strokeColor = fgColor.cgColor
        layer.addSublayer(fgLayer)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
