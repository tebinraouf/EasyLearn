//
//  DetailDeserializer.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


public struct DetailDeserializer {
    private var data: JSON
    
    public init(_ data: JSON) {
        self.data = data
    }
    public var detail: Detail {
        return Detail(id, definition, register, examples, subDetails)
    }
    
    //Detail
    public var id: String? {
        guard let id = data["id"].string else { return nil }
        return id
    }
    public var definition: String? {
        guard let definition = data["definitions"][0].string else { return nil }
        return definition
    }
    public var register: String? {
        guard let register = data["registers"][0].string else { return nil }
        return register
    }
    public var examples: [String] {
        var examples = [String]()
        for (index, _) in data["examples"].enumerated() {
            var eachExample = String()
            if let example = data["examples"][index]["text"].string {
                eachExample = example
            }
            examples.append(eachExample)
        }
        return examples
    }
    public var subDetails: [SubDetail] {
        var subDetails = [SubDetail]()
        for (index, _) in data["subsenses"].enumerated() {
            let subDetail = SubDetail()
            
            //sub 1 word ID
            if let subWordId = data["subsenses"][index]["id"].string {
                subDetail.subWordId = subWordId
            }
            
            //sub 2 word definition
            if let subDefinition = data["subsenses"][index]["definitions"][0].string {
                subDetail.subDefinition = subDefinition
            }
            
            //sub 3 word examples
            var subExamples = [String]()
            for (subIndex, _) in data["subsenses"][index]["examples"].enumerated() {
                var subEachExample = String()
                if let subExample = data["subsenses"][index]["examples"][subIndex]["text"].string {
                    subEachExample = subExample
                }
                subExamples.append(subEachExample)
            }
            subDetail.subExamples = subExamples
            
            //sub 4 word register
            if let subRegister = data["subsenses"][index]["registers"][0].string {
                subDetail.subRegister = subRegister
            }
            subDetails.append(subDetail)
        }
        return subDetails
    }
}
