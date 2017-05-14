//
//  Builder.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


/*
 - Build a word model from json data
 */

class Builder {
    func wordFromData(_ data: JSON?) -> Word? {
        guard let data = data else { return nil }
        let deserializer = WordDeserializer(data: data)
        let wordCreator = WordCreator(deserializer)
        let word = wordCreator.create
        return word
    }
    func domainsFromData(_ data: JSON?) -> [Domain]? {
        guard let data = data else { return nil }
        let domainDeserializer = DomainDeserializer(data)
        return domainDeserializer.getDomains()
    }
    func domainWords(_ data: JSON?) -> [Word]? {
        guard let data = data else { return nil }
        let dwd = DomainWordDeserializer(data)
        return dwd.getDomainWords()
    }
}


//Domain Word

struct DomainWordDeserializer {
    public var data: JSON
    init(_ data: JSON) {
        self.data = data
    }
    func getDomainWords() -> [Word] {
        var domainsWords = [Word]()
        //print(data["results"])
        let json = data["results"]
        //print(json)
        for (_,subJson):(String, JSON) in json {
            let word  = Word()
            word.id = subJson["id"].string!
            word.word = subJson["word"].string!
                
            domainsWords.append(word)
        }
        return domainsWords
    }
}



//Domain
struct DomainDeserializer {
    public var data: JSON
    init(_ data: JSON) {
        self.data = data
    }
    func getDomains() -> [Domain] {
        var domains = [Domain]()
        
        let json = data["results"].dictionary

        for (key,subJson):(String, JSON) in json! {
            
            let domain  = Domain(key: key, name: subJson["en"].string!)
            domains.append(domain)
        }
        
        return domains
    }
}


struct DomainGenerator {
    var domains: [Domain] {
        var domains = [Domain]()
        let clockMaking = Domain(key: "Clockmaking", name: "Clockmaking")
        let tennis = Domain(key: "Tennis", name: "Tennis")
        let textiles = Domain(key: "Textiles", name: "Textiles")
        let broadcasting = Domain(key: "Broadcasting", name: "Broadcasting")
        let shoemaking = Domain(key: "Shoemaking", name: "Shoemaking")
        let snowboarding = Domain(key: "Snowboarding", name: "Snowboarding")
        let ancientHistory = Domain(key: "Ancient_History", name: "Ancient History")
        let dyeing = Domain(key: "Dyeing", name: "Dyeing")
        let zoology = Domain(key: "Zoology", name: "Zoology")
        let surfing  = Domain(key: "Surfing", name: "Surfing")
        domains = [clockMaking, tennis, textiles, broadcasting, shoemaking, snowboarding, ancientHistory, dyeing, zoology, surfing]
        return domains
    }
}

