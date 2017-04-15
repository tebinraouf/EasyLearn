//
//  CardBgColorController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardBgColorController: UIViewController {
    
    
    var alpha: CGFloat = 1
    
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Card","New"]) //this view controller becomes segment 0 and segment 1 becomes another view controller
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
        label.layer.opacity = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var circleButton: CircleButton = {
        let btn = CircleButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .clear
        btn.setImage(UIImage.icon(from: .FontAwesome, code: "plus", imageSize: CGSize(width: 30, height: 30), ofSize: 30, color: .white), for: .normal)
        return btn
    }()
    
    let bgLayer = CAShapeLayer()
    let bgColor = UIColor.appGray
    
    let fgLayer = CAShapeLayer()
    let fgColor = UIColor.black
    
    
    let userSettings = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appColor
        navigationItem.titleView = segmentedControl
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRandomColor))
        
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        touchableView.addGestureRecognizer(panGesture)
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(gesture:)))
        touchableView.addGestureRecognizer(pinchGesture)
        
        setupView()
        
    }
    
    func setupView(){
        
        view.addSubview(touchableView)
        view.addSubview(sliderRed)
        view.addSubview(sliderGreen)
        view.addSubview(sliderBlue)
        view.addSubview(alphaLabel)

        touchableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        touchableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        touchableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        touchableView.bottomAnchor.constraint(equalTo: sliderRed.topAnchor, constant: -20).isActive = true

        sliderRed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sliderRed.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        sliderRed.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderRed.bottomAnchor.constraint(equalTo: sliderGreen.topAnchor, constant: -20).isActive = true

        sliderRed.addTarget(self, action: #selector(handleRed), for: .valueChanged)
        
        
        sliderGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sliderGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        sliderGreen.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderGreen.bottomAnchor.constraint(equalTo: sliderBlue.topAnchor, constant: -20).isActive = true
        
        sliderGreen.addTarget(self, action: #selector(handleGreen), for: .valueChanged)
        
        
        sliderBlue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sliderBlue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        sliderBlue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sliderBlue.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        sliderBlue.addTarget(self, action: #selector(handleBlue), for: .valueChanged)
        
        
        
        alphaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alphaLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alphaLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        alphaLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        bgLayer.opacity = 0
        bgLayer.lineWidth = 10.0
        bgLayer.fillColor = nil
        bgLayer.strokeEnd = 1
        bgLayer.strokeColor = bgColor.cgColor
        view.layer.addSublayer(bgLayer)
        
        fgLayer.opacity = 0
        fgLayer.lineWidth = 10.0
        fgLayer.fillColor = nil
        fgLayer.strokeEnd = 0
        fgLayer.strokeColor = fgColor.cgColor
        view.layer.addSublayer(fgLayer)
        
        //setup circle
        setupCircleView()
        
        //random background color when view is loaded
        handleRandomColor()
    }
    
    //Setup Circle View
    func setupCircleView() {
        view.addSubview(circleButton)
        circleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        circleButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        circleButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circleButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        circleButton.addTarget(self, action: #selector(handleNewColor), for: .touchDown)
    }
    func handleNewColor(){
        circleButton.animate()
    }
    
    func handleRandomColor(){
        let randomRed = arc4random_uniform(255)
        let randomGreen = arc4random_uniform(255)
        let randomBlue = arc4random_uniform(255)
        
        sliderRed.value = Float(randomRed)
        sliderGreen.value = Float(randomGreen)
        sliderBlue.value = Float(randomBlue)
        
        handleBackgroundColor()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupShapeLayer(shapeLayer: bgLayer)
        setupShapeLayer(shapeLayer: fgLayer)
        alphaLabel.text = String(format: "%1.2f", alpha)
    }
    
    func setupShapeLayer(shapeLayer: CAShapeLayer){
        shapeLayer.frame = view.bounds
        let startAngle = DegreesToRadians(135.0)
        let endAngle = DegreesToRadians(45.0)
        let center = view.center
        let radius: CGFloat = 80
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = path.cgPath
    }
    func DegreesToRadians (_ value:CGFloat) -> CGFloat {
        return value * CGFloat(Double.pi) / 180.0
    }
    
    func handleRed(){
        print("SliderRed Value: ",sliderRed.value)
        setUserSettings(for: sliderRed.value, forKey: "red")
        handleBackgroundColor()
    }
    func handleGreen(){
        setUserSettings(for: sliderGreen.value, forKey: "green")
        handleBackgroundColor()
    }
    func handleBlue(){
        //setUserSettings(for: sliderBlue.value, forKey: "blue")
        handleBackgroundColor()
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
            sliderRed.value = Float(red)
            sliderGreen.value = Float(green)
            sliderBlue.value = Float(blue)
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
            alphaLabel.layer.opacity = 0.5
        }else if gesture.state == .ended {
            //bgLayer.opacity = 0
            //fgLayer.opacity = 0
            alphaLabel.layer.opacity = 0
            animate(fromValue: 0.5, toValue: 0)
        }
        
        handleBackgroundColor()
        
    }
    
    //not seeing the effect!
    func animate(fromValue: Float, toValue: Float) {
        //let toValue: Float = 0
        
        // 1
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromValue
        animation.toValue = toValue
        // 2
        bgLayer.removeAnimation(forKey: "opacityKey")
        bgLayer.add(animation, forKey: "opacityKey")
        
        fgLayer.removeAnimation(forKey: "opacityKey2")
        fgLayer.add(animation, forKey: "opacityKey2")
        
        bgLayer.opacity = toValue
        fgLayer.opacity = toValue
    }
    
    func setUserSettings(for value: Float, forKey: String) {
        userSettings.setValue(value, forKey: forKey)
        userSettings.synchronize()
    }
    func handleBackgroundColor() {
        
        //sliderRed.thumbTintColor = UIColor(r: CGFloat(sliderRed.value), g: CGFloat(sliderGreen.value), b: CGFloat(sliderBlue.value), a: 1)
        
        let redImage = progressImage(with: sliderRed.value, color: .red, textColor: .black)
        sliderRed.setThumbImage(redImage, for: .normal)
        
        
        let greenImage = progressImage(with: sliderGreen.value, color: .green, textColor: .black)
        sliderGreen.setThumbImage(greenImage, for: .normal)
        
        let blueImage = progressImage(with: sliderBlue.value, color: .blue, textColor: .black)
        sliderBlue.setThumbImage(blueImage, for: .normal)
        
        view.backgroundColor = UIColor(r: CGFloat(sliderRed.value), g: CGFloat(sliderGreen.value), b: CGFloat(sliderBlue.value), a: alpha)
    }
    
        
    
    
    
}





