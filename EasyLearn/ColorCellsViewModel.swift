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
    func saveDefaultColor(for row: Int, at indexPath: IndexPath) {
        let rgb = colors[indexPath.item]
        coreDataLayer.resetPreviousDefault(for: row)
        coreDataLayer.saveDefaultColor(rgb, for: row)
    }
    func saveSampleCardProperties() -> [UIColor] {
        let properties = ["isCardColor","isTextColor","isViewColor"]
        var color: Color!
        var colors = [UIColor]()
        
        color = coreDataLayer.getColor(for: properties[0])
        if let red = color?.red, let green = color?.green, let blue = color?.blue {
             colors.append(UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: 1))
        }
        color = coreDataLayer.getColor(for: properties[1])
        if let red = color?.red, let green = color?.green, let blue = color?.blue {
            colors.append(UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: 1))
        }
        color = coreDataLayer.getColor(for: properties[2])
        if let red = color?.red, let green = color?.green, let blue = color?.blue {
            colors.append(UIColor(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), a: 1))
        }
        return colors
    }
}
