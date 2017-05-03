//
//  Service.swift
//  EasyLearn
//
//  Created by Tebeen on 3/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON



class WebService {
    
    private var url = "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/"
    private var resource: Resource
    
    public init(_ word: String, filters: [OxfordFilters]) {
        resource = Resource(url, word, filters)
    }
    public init(_ word: String, _ lexicalCategory: String, filters: [OxfordFilters]) {
        resource = Resource(url, word, lexicalCategory, filters)
    }
    public var request: URLRequest? {
        return resource.request
    }
    public func get(_ completion: @escaping ((Word?, Status)->())) {
        let builder = Builder()
        resource.load { (data, status) in
            DispatchQueue.main.async {
                let word = builder.wordFromData(data)
                completion(word, status)
            }
        }
    }
    public func get(details completion: @escaping ([Detail]?, Status)->()) {
        let builder = Builder()
        resource.load { (data, status) in
            //filter the data
            let detailData = data?["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]
            DispatchQueue.main.async {
                let word = builder.wordFromData(detailData)
                completion(word?.details, status)
            }
        }
    }
}






