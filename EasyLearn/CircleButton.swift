//
//  CircleView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    var circleLayer: CAShapeLayer!
    var circleLayerBack: CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        let radius = frame.size.width/2.0
        let endAngle = CGFloat(.pi * 2.0)
        let backPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: endAngle, clockwise: true)
        circleLayerBack = CAShapeLayer()
        circleLayerBack.fillColor = UIColor.clear.cgColor
        circleLayerBack.lineWidth = 5
        circleLayerBack.strokeEnd = 1
        circleLayerBack.strokeColor = UIColor.white.cgColor
        circleLayerBack.opacity = 0.3
        circleLayerBack.path = backPath.cgPath
        layer.addSublayer(circleLayerBack)
        let frontPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: endAngle, clockwise: true)
        circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 5
        circleLayer.strokeEnd = 0
        circleLayer.path = frontPath.cgPath
        layer.addSublayer(circleLayer)
    }
    func animate(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval(1)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        circleLayer.strokeEnd = 1
        circleLayer.add(animation, forKey: "animate")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
