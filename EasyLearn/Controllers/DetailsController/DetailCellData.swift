//
//  CellData.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation

struct DetailCellData<T: WordPresentable> {
    private var cell: DetailsCell
    private var data: DataGenerator<T>
    
    public init(_ data: DataGenerator<T>, _ cell: DetailsCell) {
        self.data = data
        self.cell = cell
    }

    public func populateCell() {
        cell.textViewText = data.cellText
        cell.cellNumberText = data.cellNumber
        cell.bookmarkIconText = data.bookmarkText
    }
    
}
