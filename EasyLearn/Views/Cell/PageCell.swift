//
//  PageCell.swift
//  EasyLearn
//
//  Created by Tebeen on 5/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    var page: Page? {
        didSet {
            guard let page = page else { return }
            background.image = page.image
            titleLabel.text = page.title
            descriptionLabel.text = page.description
        }
    }
    var background: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Word Definition"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Word Description"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    var gradientLayer = CAGradientLayer()
    override func setupView() {
        setupGradientColor()
        addSubViews()
        backgroundSetup()
        titleSetup()
        descriptionSetup()
    }
    override func layoutSubviews() {
        setupView()
    }
    func addSubViews(){
        addSubview(background)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    func backgroundSetup(){
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    func titleSetup(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    func descriptionSetup(){
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
            ])
    }
    func setupGradientColor() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor(r: 203, g: 45, b: 62, a: 1).cgColor, UIColor(r: 239, g: 71, b: 58, a: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
}
