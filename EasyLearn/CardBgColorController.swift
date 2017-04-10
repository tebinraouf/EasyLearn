//
//  CardBgColorController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardBgColorController: UIViewController {
    
    
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Card","New"]) //this view controller becomes segment 0 and segment 1 becomes another view controller
        sc.selectedSegmentIndex = 0
        sc.setWidth(100, forSegmentAt: 0)
        sc.setWidth(100, forSegmentAt: 1)
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appColor
        navigationItem.titleView = segmentedControl
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        view.addGestureRecognizer(gesture)
        
        
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        let translation = gesture.translation(in: view)
        gesture.setTranslation(translation, in: view)
        print(translation)
        
        
        var red = translation.x
        var green = translation.y
        var blue = red + green
        
        view.backgroundColor = UIColor(r: red, g: green, b: blue, a: 1)
        
        
        if gesture.state == .began {
            
        } else if gesture.state == .ended {
            
        }
        
        
        
    }
}
