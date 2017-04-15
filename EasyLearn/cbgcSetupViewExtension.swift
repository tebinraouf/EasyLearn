//
//  cbgcSetupViewExtension.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardBgColorController {
    func setupView(){
        view.addSubview(colorView)
        
        colorView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        navigationItems()
        setupClickableViews()
        
    }
    func navigationItems(){
        navigationItem.titleView = colorView.segmentedControl
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRandomColor))
    }
    
    func setupClickableViews(){
        colorView.sliderRed.addTarget(self, action: #selector(handleRed), for: .valueChanged)
        colorView.sliderGreen.addTarget(self, action: #selector(handleGreen), for: .valueChanged)
        colorView.sliderBlue.addTarget(self, action: #selector(handleBlue), for: .valueChanged)
        colorView.circleButton.addTarget(self, action: #selector(handleNewColor), for: .touchDown)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        colorView.touchableView.addGestureRecognizer(panGesture)
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))
        colorView.touchableView.addGestureRecognizer(pinchGesture)
        
    }
    
    
    
}
