//
//  Models.swift
//  EasyLearn
//
//  Created by Tebeen on 3/4/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation


class Word: NSObject {
    var language: String?
    var id: String?
    var word: String?
    var type: String?
    var lexicalEntries: [String]?
    var details: [Detail]?
}
class Detail {
    var wordId: String?
    var definition: String?
    var examples: [String]?
    var register: String?
    var subdetails: [SubDetail]?
}
class SubDetail {
    var subWordId: String?
    var subDefinition: String?
    var subRegister: String?
    var subExamples: [String]?
}
