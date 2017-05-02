//
//  TextFormatter.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

struct TextFormatter {
    private var text: String = ""
    private var texts: NSMutableAttributedString
    
    public init() {
        texts = NSMutableAttributedString()
    }
    public func combinedText() -> NSMutableAttributedString {
        return texts
    }
    public func append(_ text: String) {
        texts.append(getAttributtedStringFor(text).attr)
    }
    public func append(_ attrText: NSAttributedString) {
        texts.append(attrText)
    }
    public mutating func setText(_ text: String) {
        self.text = text
    }
    public func getText() -> String {
        return text
    }
    public func getAttributtedStringFor(_ text: String) -> (obj: CustomAttributtedString, attr: NSMutableAttributedString) {
        let custom00 = CustomAttributtedString(text: text)
        let mainAttributtedString = custom00.getAttributtedString()
        return (obj: custom00, attr: mainAttributtedString)
    }
}
