//
//  ColorCellsViewModel.swift
//  EasyLearn
//
//  Created by Tebeen on 4/16/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import UIKit

class ColorCellsViewModel {
    let coreDataLayer = ColorCoreDataLayer()
    var colors: [Color] {
        return coreDataLayer.fetchColors()!.reversed()
    }
    var cellBackground: UIColor {
        return .green
    }
    var count: Int  {
        return coreDataLayer.numberOfColors
    }
    init() {
        
    }
    func backgroundColorForItemAt(_ indexPath: IndexPath) -> UIColor {
        let color = colors[indexPath.item]
        return UIColor(r: CGFloat(color.red), g: CGFloat(color.green), b: CGFloat(color.blue), a: 1)
    }
    func saveDefaultColor(at indexPath: IndexPath) {
        let rgb = colors[indexPath.item]
        print(rgb.red, rgb.green, rgb.blue)
        coreDataLayer.saveDefault(rgb)
    }
}
