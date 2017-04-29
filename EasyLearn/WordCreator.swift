//
//  WordCreator.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation

public struct WordCreator {
    private var deserializer: WordDeserializer
    private var word = Word()
    
    public init(_ deserializer: WordDeserializer) {
        self.deserializer = deserializer
    }
    public var create: Word {
        word.word = deserializer.word
        word.id = deserializer.id
        word.lexicalEntries = deserializer.lexicalEntries
        word.details = deserializer.details
        return word
    }
}
