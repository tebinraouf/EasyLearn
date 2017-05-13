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
}


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
        let broadcasting = Domain(key: "broadcasting", name: "broadcasting")
        let shoemaking = Domain(key: "shoemaking", name: "shoemaking")
        let snowboarding = Domain(key: "snowboarding", name: "snowboarding")
        let ancientHistory = Domain(key: "Ancient_History", name: "Ancient History")
        let dyeing = Domain(key: "Dyeing", name: "Dyeing")
        let zoology = Domain(key: "Zoology", name: "Zoology")
        let surfing  = Domain(key: "Surfing", name: "Surfing")
        domains = [clockMaking, tennis, textiles, broadcasting, shoemaking, snowboarding, ancientHistory, dyeing, zoology, surfing]
        return domains
    }
}

