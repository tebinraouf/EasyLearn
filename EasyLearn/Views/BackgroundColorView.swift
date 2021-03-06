//
//  CardSettingsView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/14/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

protocol BackgroundColorProtocol {
    func handleRed()
    func handleGreen()
    func handleBlue()
    func handleNewColor()
    func handlePanGesture(gesture: UIPanGestureRecognizer)
    func handlePinchGesture(gesture: UIPinchGestureRecognizer)
}

class BackgroundColorView: UIView {
    var segmentedControl: UISegmentedControl = {
        //this view controller becomes segment 0 and segment 1 becomes another view controller
        let sc = UISegmentedControl(items: ["Card","New"])
        sc.selectedSegmentIndex = 0
        sc.setWidth(100, forSegmentAt: 0)
        sc.setWidth(100, forSegmentAt: 1)
        return sc
    }()
    var sliderRed: UISlider = {
        let slider  = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 127.5
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .red
        slider.thumbTintColor = .red
        return slider
    }()
    var sliderGreen: UISlider = {
        let slider  = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 127.5
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .green
        slider.thumbTintColor = .green
        return slider
    }()
    var sliderBlue: UISlider = {
        let slider  = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.value = 127.5
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .blue
        slider.thumbTintColor = .blue
        return slider
    }()
    var touchableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    var alphaLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.layer.opacity = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let alphaView: AlphaView = {
        let av = AlphaView()
        av.translatesAutoresizingMaskIntoConstraints = false
        av.backgroundColor = .clear
        return av
    }()
    var circleButton: CircleButton = {
        let btn = CircleButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .clear
        btn.setImage(UIImage.icon(from: .FontAwesome, code: "plus", imageSize: CGSize(width: 30, height: 30), ofSize: 30, color: .white), for: .normal)
        return btn
    }()
    var redValue: Int16 {
        get {
            return Int16(sliderRed.value)
        }
        set {
            sliderRed.value = Float(newValue)
        }
    }
    var greenValue: Int16 {
        get {
            return Int16(sliderGreen.value)
        }
        set {
            sliderGreen.value = Float(newValue)
        }
    }
    var blueValue: Int16 {
        get {
            return Int16(sliderBlue.value)
        }
        set {
            sliderBlue.value = Float(newValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func addViewsToMainView() {
        addSubview(alphaView)
        addSubview(touchableView)
        addSubview(sliderRed)
        addSubview(sliderGreen)
        addSubview(sliderBlue)
        addSubview(alphaLabel)
        addSubview(circleButton)
    }
    func setupView() {
        addViewsToMainView()
        touchableViewSetup()
        sliderRedSetup()
        sliderGreenSetup()
        sliderBlueSetup()
        alphaLabelSetup()
        alphaViewSetup()
        circleViewSetup()
    }
    func touchableViewSetup() {
        touchableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        touchableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        touchableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        touchableView.bottomAnchor.constraint(equalTo: sliderRed.topAnchor, constant: -20).isActive = true
    }
    func sliderRedSetup() {
        sliderRed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        sliderRed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        sliderRed.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderRed.bottomAnchor.constraint(equalTo: sliderGreen.topAnchor, constant: -20).isActive = true
    }
    func sliderGreenSetup() {
        sliderGreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        sliderGreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        sliderGreen.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderGreen.bottomAnchor.constraint(equalTo: sliderBlue.topAnchor, constant: -20).isActive = true
    }
    func sliderBlueSetup() {
        sliderBlue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        sliderBlue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        sliderBlue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderBlue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    func alphaLabelSetup() {
        alphaLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        alphaLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alphaLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        alphaLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    func alphaViewSetup() {
        NSLayoutConstraint.activate([
            alphaView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alphaView.centerYAnchor.constraint(equalTo: centerYAnchor),
            alphaView.heightAnchor.constraint(equalToConstant: 160),
            alphaView.widthAnchor.constraint(equalToConstant: 160)
            ])
    }
    func circleViewSetup() {
        NSLayoutConstraint.activate([
            circleButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            circleButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            circleButton.widthAnchor.constraint(equalToConstant: 60),
            circleButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
