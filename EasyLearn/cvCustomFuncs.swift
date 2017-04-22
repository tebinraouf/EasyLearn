//
//  cvCustomFuncs.swift
//  EasyLearn
//
//  Created by Tebeen on 3/30/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

extension CardsViewController {

    final func handleNavIcons(){
        
        let settings = barButtonWith(code: "cog", handleBy:  #selector(handleSetting))
        navigationItem.rightBarButtonItem = settings
        
        
        let swap = barButtonWith(code: "exchange", handleBy:  #selector(handleCardSwap))
        let shuffle  = barButtonWith(code: "random", handleBy: #selector(handleShuffle))
        let sortAsc = barButtonWith(code: "sort-alpha-asc", handleBy: #selector(handleSortAsc))
        let sortDesc = barButtonWith(code: "sort-alpha-desc", handleBy: #selector(handleSortDesc))
        let play = barButtonWith(code: "play", handleBy: #selector(handlePlay))
        cardView.toolBar.items = [swap, .space, shuffle, .space, sortAsc, .space, sortDesc, .space, play]

    }

    final func handleSetting(){
        let cardSettingsController = CardSettingsController()
        navigationController?.pushViewController(cardSettingsController, animated: true)
    }
    func cancelPresentViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    final func handleCardSwap(){
        let wordName = (cellReference?.flashCardView.wordName)!
        wordName.isHidden ? (isSwapped = false) : (isSwapped = true)
        cardView.flashCV.reloadData()
    }

    final func handleShuffle(){
        favWords.shuffle()
        cardView.flashCV.reloadData()
    }

    final func handleSortAsc(){
        favWords.sort { return $0.0.word! < $0.1.word! }
        cardView.flashCV.reloadData()
    }
    
    final func handleSortDesc(){
        favWords.sort { return $0.0.word! > $0.1.word! }
        cardView.flashCV.reloadData()
    }
    
    final func handlePlay(){
        
        if isPlayClicked {
            let play = barButtonWith(code: "play", handleBy: #selector(handlePlay))
            cardView.toolBar.items?.removeLast()
            cardView.toolBar.items?.insert(play, at: 8)
            playTimer?.invalidate()
            playTimer = nil
            isPlayClicked = false
        } else {
            let play = barButtonWith(code: "pause", handleBy: #selector(handlePlay), size: 18.5)
            cardView.toolBar.items?.removeLast()
            cardView.toolBar.items?.insert(play, at: 8)
            startTimer()
            playTimer?.fire()
            isPlayClicked = true
        }
        
    }
    
    final func barButtonWith(code: String, handleBy selector: Selector, size: CGFloat? = nil) -> UIBarButtonItem {
        let btn = UIBarButtonItem()
        btn.icon(from: .FontAwesome, code: code, ofSize: size ?? 20)
        btn.target = self
        btn.action = selector
        return btn
    }
    final func startTimer() {
        let speedValue = UserDefaults.standard.double(forKey: UserDefaultsKeys.cardSpeedValue.rawValue)
        
        playTimer = Timer.scheduledTimer(timeInterval: speedValue, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    final func scrollToNextCell(){
        //get cell size
        let cellSize = CGSize(width: self.cardView.flashCV.frame.width, height: self.cardView.flashCV.frame.height)
        
        //get current content Offset of the Collection view
        let contentOffset = cardView.flashCV.contentOffset;
        
        let cgRectX = contentOffset.x + cellSize.width
        let contentWidth = cardView.flashCV.contentSize.width
        
        
        //scroll to next cell
        if contentWidth <= cgRectX {
            cardView.flashCV.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        }else {
            cardView.flashCV.scrollRectToVisible(CGRect(x: cgRectX, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        }
        
    }
    
    //Settings Updates
    func updateColors(_ cell: FlashCardCell?){
        if let cell = cell {
            let cardViewModel = CardViewModel(cell, cardView)
            cardViewModel.changeCellBackgroundColor()
        }
    }
    func updateCardLabel(_ cell: FlashCardCell?){
        
        if let cell = cell {
            let isCardNumberLabelHidden = UserDefaults.standard.bool(forKey: UserDefaultsKeys.cardNumberLabel.rawValue)
            if !isCardNumberLabelHidden {
                cell.flashCardView.cardNumber.isHidden = true
            } else {
                cell.flashCardView.cardNumber.isHidden = false
            }
        }
        
    }
    
}


