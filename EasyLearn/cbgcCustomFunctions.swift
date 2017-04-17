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
        let redImage = progressImage(with: colorView.redValue, color: .red, textColor: .black)
        colorView.sliderRed.setThumbImage(redImage, for: .normal)
        let greenImage = progressImage(with: colorView.greenValue, color: .green, textColor: .black)
        colorView.sliderGreen.setThumbImage(greenImage, for: .normal)
        let blueImage = progressImage(with: colorView.blueValue, color: .blue, textColor: .black)
        colorView.sliderBlue.setThumbImage(blueImage, for: .normal)
        view.backgroundColor = UIColor(r: CGFloat(colorView.redValue), g: CGFloat(colorView.greenValue), b: CGFloat(colorView.blueValue), a: alpha)
    }
    func handleRandomColor() {
        let cvm = ColorViewModel(colorView: colorView)
        cvm.updateSliders()
        handleBackgroundColor()
    }
    func updateSubViews() {
        colorView.alphaView.setupShapeLayer(colorView.alphaView.bgLayer)
        colorView.alphaView.setupShapeLayer(colorView.alphaView.fgLayer)
        colorView.alphaLabel.text = String(format: "%1.2f", alpha)
        updateAlphaStartEnd()
    }
    func updateAlphaStartEnd() {
        if alpha <= 0.01 {
            colorView.alphaLabel.text = String(format: "%1.2f", 0.00)
            colorView.alphaView.fgLayer.strokeEnd = 1
        } else if alpha >= 1.00 {
            colorView.alphaView.fgLayer.strokeEnd = 0
        }
    }
    
}
