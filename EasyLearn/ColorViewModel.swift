//
//  ColorViewModel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ColorViewModel {
    var red: Int
    var green: Int
    var blue: Int
    var colorView: BackgroundColorView
    
    init(colorView: BackgroundColorView) {
        self.red = colorView.redValue
        self.green = colorView.greenValue
        self.blue = colorView.blueValue
        self.colorView = colorView
    }
    func updateSliders(){
        let generatedRGB = generateRandomColors()
        colorView.redValue = generatedRGB.red
        colorView.greenValue = generatedRGB.green
        colorView.blueValue = generatedRGB.blue
        setUserSettings(for: colorView.redValue, forKey: "red")
        setUserSettings(for: colorView.greenValue, forKey: "green")
        setUserSettings(for: colorView.blueValue, forKey: "blue")
    }
    func generateRandomColors() -> (red: Int, green: Int, blue: Int) {
        let randomRed = Int(arc4random_uniform(255))
        let randomGreen = Int(arc4random_uniform(255))
        let randomBlue = Int(arc4random_uniform(255))
        return (randomRed, randomGreen, randomBlue)
    }
    func newColor() -> (r: Int, g: Int, b: Int) {
        return (red, green, blue)
    }
}
