//
//  BaseCell.swift
//  EasyLearn
//
//  Created by Tebeen on 3/13/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView(){
        //setup views here
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


