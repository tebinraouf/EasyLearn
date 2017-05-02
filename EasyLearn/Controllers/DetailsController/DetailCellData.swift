//
//  CellData.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation

struct DetailCellData {
    private var cell: DetailsCell
    private var data: DataGenerator
    
    public init(_ data: DataGenerator, _ cell: DetailsCell) {
        self.data = data
        self.cell = cell
        
    }
    public func populateCell() {
        cell.textViewText = data.cellText
        cell.cellNumberText = data.cellNumber
        cell.bookmarkIconText = data.bookmarkText
    }
    
}
