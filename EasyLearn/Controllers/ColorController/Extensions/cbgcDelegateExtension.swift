//
//  cbgcDelegateExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardBgColorController: BackgroundColorProtocol {
    func handleRed() {
        setUserSettings(for: colorView.redValue, forKey: "red")
        handleBackgroundColor()
    }
    func handleGreen() {
        setUserSettings(for: colorView.greenValue, forKey: "green")
        handleBackgroundColor()
    }
    func handleBlue() {
        setUserSettings(for: colorView.blueValue, forKey: "blue")
        handleBackgroundColor()
    }
    //circle button handler
    func handleNewColor() {
        
        let cvm = ColorViewModel(colorView: colorView)
        let newColor = cvm.newColor()
        let currentLayer = ColorCoreDataLayer()
        let isSaved = currentLayer.isColorSaved(rgb: newColor, alpha: Double(alpha))
        if !isSaved {
            colorView.circleButton.animate()
            currentLayer.addColor(rgb: newColor, alpha: Double(alpha))
        } else {
          alert(title: "Color Saved", message: "The color is already saved.", viewController: self)
        }
    }
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        gesture.setTranslation(translation, in: view)
        gesture.maximumNumberOfTouches = 1
        let lastRed = CGFloat(UserDefaults.standard.float(forKey: "red"))
        let lastGreen = CGFloat(UserDefaults.standard.float(forKey: "green"))
        //remove existing value
        if lastRed > 255 {
            UserDefaults.standard.removeObject(forKey: "red")
            UserDefaults.standard.synchronize()
        }
        if lastGreen > 255 {
            UserDefaults.standard.removeObject(forKey: "green")
            UserDefaults.standard.synchronize()
        }
        let red = translation.x + lastRed
        let green = translation.y + lastGreen
        if gesture.state == .changed {
            colorView.redValue = Int16(red)
            colorView.greenValue = Int16(green)
        }
        if gesture.state == .ended {
            setUserSettings(for: red, forKey: "red")
            setUserSettings(for: green, forKey: "green")
        }
        handleBackgroundColor()
    }
    func handlePinchGesture(gesture: UIPinchGestureRecognizer) {
        if gesture.scale > 1 && alpha < 1 {
            alpha += 0.01
            colorView.alphaView.fgLayer.strokeEnd -= 0.01
        } else if gesture.scale < 1 && alpha > 0.01 {
            alpha -= 0.01
            //add to strokeEnd
            colorView.alphaView.fgLayer.strokeEnd += 0.01
        }
        if gesture.state == .began {
            colorView.alphaView.animate(fromValue: 0, toValue: 0.5)
            colorView.alphaLabel.layer.opacity = 0.5
        } else if gesture.state == .ended {
            colorView.alphaLabel.layer.opacity = 0
            colorView.alphaView.animate(fromValue: 0.5, toValue: 0)
        }
        handleBackgroundColor()
    }
}
