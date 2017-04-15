//
//  ColorImageSelectorView.swift
//  EasyLearn
//
//  Created by Tebeen on 4/15/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class ColorImageSelectorView: UIView {
    let mainCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    let sampleCardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    let labelViews: FlashCardView = {
        let lv = FlashCardView()
        lv.wordName.font = UIFont.systemFont(ofSize: 20)
        return lv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func addSubViews(){
        addSubview(mainCardView)
        mainCardView.addSubview(sampleCardView)
        sampleCardView.addSubview(labelViews)
    }
    func setupView(){
        addSubViews()
        setupCardViewMain()
        setupSampleCardView()
        setupLabelViews()
    }
    func setupCardViewMain(){
        NSLayoutConstraint.activate([
            mainCardView.topAnchor.constraint(equalTo: topAnchor),
            mainCardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33)
        ])
    }
    func setupSampleCardView(){
        NSLayoutConstraint.activate([
            sampleCardView.topAnchor.constraint(equalTo: mainCardView.topAnchor, constant: 10),
            sampleCardView.bottomAnchor.constraint(equalTo: mainCardView.bottomAnchor, constant: -10),
            sampleCardView.leadingAnchor.constraint(equalTo: mainCardView.leadingAnchor, constant: 80),
            sampleCardView.trailingAnchor.constraint(equalTo: mainCardView.trailingAnchor, constant: -80)
        ])
    }
    func setupLabelViews(){
        NSLayoutConstraint.activate([
            labelViews.topAnchor.constraint(equalTo: sampleCardView.topAnchor),
            labelViews.bottomAnchor.constraint(equalTo: sampleCardView.bottomAnchor),
            labelViews.leadingAnchor.constraint(equalTo: sampleCardView.leadingAnchor),
            labelViews.trailingAnchor.constraint(equalTo: sampleCardView.trailingAnchor)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
