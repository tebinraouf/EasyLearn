//
//  cbgcCustomFunctions.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardBgColorController {
    func handleBackgroundColor() {
        let redImage = progressImage(with: colorView.sliderRed.value, color: .red, textColor: .black)
        colorView.sliderRed.setThumbImage(redImage, for: .normal)
        
        let greenImage = progressImage(with: colorView.sliderGreen.value, color: .green, textColor: .black)
        colorView.sliderGreen.setThumbImage(greenImage, for: .normal)
        
        let blueImage = progressImage(with: colorView.sliderBlue.value, color: .blue, textColor: .black)
        colorView.sliderBlue.setThumbImage(blueImage, for: .normal)
        
        view.backgroundColor = UIColor(r: CGFloat(colorView.sliderRed.value), g: CGFloat(colorView.sliderGreen.value), b: CGFloat(colorView.sliderBlue.value), a: alpha)
    }

    func handleRandomColor(){
        let randomRed = arc4random_uniform(255)
        let randomGreen = arc4random_uniform(255)
        let randomBlue = arc4random_uniform(255)
        
        colorView.sliderRed.value = Float(randomRed)
        colorView.sliderGreen.value = Float(randomGreen)
        colorView.sliderBlue.value = Float(randomBlue)
        
        handleBackgroundColor()
    }
    func updateSubViews(){
        colorView.alphaView.setupShapeLayer(colorView.alphaView.bgLayer)
        colorView.alphaView.setupShapeLayer(colorView.alphaView.fgLayer)
        colorView.alphaLabel.text = String(format: "%1.2f", alpha)
        updateAlphaStartEnd()
    }
    func updateAlphaStartEnd(){
        if alpha <= 0.01 {
            colorView.alphaLabel.text = String(format: "%1.2f", 0.00)
            colorView.alphaView.fgLayer.strokeEnd = 1
        } else if alpha >= 1.00 {
            colorView.alphaView.fgLayer.strokeEnd = 0
        }
    }
    
}
