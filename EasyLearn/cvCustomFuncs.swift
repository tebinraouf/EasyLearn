//
//  cvCustomFuncs.swift
//  EasyLearn
//
//  Created by Tebeen on 3/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardsViewController {
    func handleNavIcons(){
        
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackButton))
        cardView.navBar.items = [backButton]
        
        
        var toolBarItems = [UIBarButtonItem]()
        
        let swap = UIBarButtonItem()
        swap.icon(from: .FontAwesome, code: "exchange", ofSize: 20)
        swap.target = self
        swap.action = #selector(handleSwap)
        toolBarItems.append(swap)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBarItems.append(spacer)
        
        let shuffle = UIBarButtonItem()
        shuffle.icon(from: .FontAwesome, code: "random", ofSize: 20)
        shuffle.target = self
        shuffle.action = #selector(handleShuffle)
        toolBarItems.append(shuffle)
        toolBarItems.append(spacer)
        
        let settings = UIBarButtonItem()
        settings.icon(from: .FontAwesome, code: "cog", ofSize: 20)
        settings.target = self
        settings.action = #selector(handleSetting)
        toolBarItems.append(settings)

        
        
        cardView.toolBar.items = toolBarItems
    }
    
    func handleSetting(){
        print("handleSetting...")
        
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseIn, animations: { 
            //self.cardView.flashCV.frame.size = CGSize(width: 200, height: 200)
            //self.cardView.flashCV.center = CGPoint(x: 100, y: self.view.center.y)
            
            //self.cardView.flashCV.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
            //self.cardView.flashCV.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            //self.cardView.flashCV.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
            //self.cellReference?.wordName.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
            
            //self.cardView.flashCV.transform = CGAffineTransform(rotationAngle: 720)
            
        }, completion: nil)
        cardView.flashCV.reloadData()
        
        
        
    }
    
    func handleBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    func handleShuffle(){
        
        favWords.shuffle()
        cardView.flashCV.reloadData()
        print("handleShuffle...")
        
    }
    
    func handleSwap(){
        
        let wordName = (cellReference?.wordName)!
        //let wordDetails = (cellReference?.wordDetails)!
        
        if wordName.isHidden {
            
            isSwapped = false
        }else{
            isSwapped = true
        }
        cardView.flashCV.reloadData()
    }
    
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
