//
//  cbgcDelegateExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardBgColorController: BackgroundColorProtocol {
    func handleRed(){
        setUserSettings(for: colorView.sliderRed.value, forKey: "red")
        handleBackgroundColor()
    }
    func handleGreen(){
        setUserSettings(for: colorView.sliderGreen.value, forKey: "green")
        handleBackgroundColor()
    }
    func handleBlue(){
        //setUserSettings(for: sliderBlue.value, forKey: "blue")
        handleBackgroundColor()
    }
    func handleNewColor(){
        colorView.circleButton.animate()
    }
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        let translation = gesture.translation(in: view)
        gesture.setTranslation(translation, in: view)
        gesture.maximumNumberOfTouches = 1
        
        
        let lastRed = CGFloat(userSettings.float(forKey: "red"))
        let lastGreen = CGFloat(userSettings.float(forKey: "green"))
        
        //remove existing value
        if lastRed > 255 {
            userSettings.removeObject(forKey: "red")
            userSettings.synchronize()
        }
        
        if lastGreen > 255 {
            userSettings.removeObject(forKey: "green")
            userSettings.synchronize()
        }
        
        
        let red = translation.x + lastRed
        let green = translation.y + lastGreen
        let blue = red + green
        
        
        if gesture.state == .changed {
            colorView.sliderRed.value = Float(red)
            colorView.sliderGreen.value = Float(green)
            colorView.sliderBlue.value = Float(blue)
        }
        
        if gesture.state == .ended {
            userSettings.set(red, forKey: "red")
            userSettings.set(green, forKey: "green")
            userSettings.synchronize()
            
        }
        
        
        
        
        
        handleBackgroundColor()
        
    }
    func handlePinchGesture(gesture: UIPinchGestureRecognizer){
        //        bgLayer.opacity = 0.5
        //        fgLayer.opacity = 0.5
        
        
        if gesture.scale > 1 {
            alpha += 0.01
            
            if alpha > 1 {
                alpha = 1
            }
            fgLayer.strokeEnd -= 0.01
            print("zoom in", alpha)
        } else if gesture.scale < 1 {
            alpha -= 0.01
            
            if alpha <= 0 {
                alpha = 0.01
            }
            //add to strokeEnd
            
            fgLayer.strokeEnd += 0.01
            
            
            print("zoom out", alpha)
        }
        
        
        
        if gesture.state == .began {
            animate(fromValue: 0, toValue: 0.5)
            colorView.alphaLabel.layer.opacity = 0.5
        }else if gesture.state == .ended {
            //bgLayer.opacity = 0
            //fgLayer.opacity = 0
            colorView.alphaLabel.layer.opacity = 0
            animate(fromValue: 0.5, toValue: 0)
        }
        
        handleBackgroundColor()
        
    }
}
