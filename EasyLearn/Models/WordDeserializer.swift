//
//  WordDeserializer.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

public struct WordDeserializer {
    public var data: JSON
    
    //Word
    public var id: String? {
        guard let id = data["results"][0]["id"].string else { return nil }
        return id
    }
    public var word: String {
        guard let word = data["results"][0]["word"].string else { return "" }
        return word
    }
    public var lexicalEntries: [String] {
        var lexicalEntriesArray = [String]()
        let lexicalEntries = data["results"][0]["lexicalEntries"]
        for (_, lexicalEntry):(String, JSON) in lexicalEntries {
            if let lexicalEntry = lexicalEntry["lexicalCategory"].string {
                lexicalEntriesArray.append(lexicalEntry)
            }
        }
        return lexicalEntriesArray
    }
    public var lexicalEntry: String {
        return lexicalEntries.first!
    }
    public var details: [Detail] {
        var details = [Detail]()
        let detailData = data["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]
        for (_, result):(String,JSON) in detailData {
            let detailsDeserializer = DetailDeserializer(result, word, lexicalEntry)
            details.append(detailsDeserializer.detail)
        }
        return details
    }
}
