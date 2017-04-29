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



class Resource {
    private let language = "en"
    private let appId = "0edbffb4"
    private let appKey = "e37ace6aa056552f46837f02bd5f0ced"
    private var url: String
    
    public init(_ url: String) {
        self.url = url
    }
    public init(_ url: String, args: String...) {
        self.url = "\(url)/"
        args.forEach { (arg) in
            self.url.append("\(arg)/")
        }
    }
    public var request: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        print("url: ",url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        return request
    }
    public var getURL: String {
        return url
    }
    func load(completion: @escaping (JSON)->()) {
        let session = URLSession.shared
        guard let request = request else { return }
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let result = JSON(data: data)
            completion(result)
            }.resume()
    }
}

class WebService {
    
    
}





enum Header: String {
    case language = "en"
    case appId = "0edbffb4"
    case appKey = "e37ace6aa056552f46837f02bd5f0ced"
}

class Service {
    
    static let sharedInstance = Service()
    
    func headers(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(Header.appId.rawValue, forHTTPHeaderField: "app_id")
        request.addValue(Header.appKey.rawValue, forHTTPHeaderField: "app_key")
        return request
    }
    func initialSearch(word: String, completion: @escaping (Word?, Error?) -> ()) {
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(Header.language.rawValue)/\(word_id)/lexicalCategory"
        let request = headers(urlString: url)
        let session = URLSession.shared
        
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            if error == nil {
                guard let data = data else { return }
                let result = JSON(data: data)
                
                DispatchQueue.main.async {
                    let deserializer = WordDeserializer(data: result)
                    let wordCreator = WordCreator(deserializer)
                    let word = wordCreator.create
                    
                    completion(word, nil)
                }
            } else {
                completion(nil, error)
            }
        })
        result.resume()
    }
    func detailsFor(word: String, lexicalCategory: String ,completion: @escaping ([Detail]?, Error?) -> ()) {
        ////lexicalCategory=noun;examples;definitions
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(Header.language.rawValue)/\(word_id)/lexicalCategory=\(lexicalCategory);examples;definitions;pronunciations;registers"
        let request = headers(urlString: url)
        let session = URLSession.shared
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            guard let data = data else { return }
            let jsonData = JSON(data: data)
            let results = jsonData["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]
            
            if error == nil {
                DispatchQueue.main.async {
                    
                    let deserializer = WordDeserializer(data: results)
                    let wordCreator = WordCreator(deserializer)
                    let word = wordCreator.create
                    
                    completion(word.details, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        })
        result.resume()
    }
    
}


public struct WordDeserializer {
    public var data: JSON
    
    //Word
    public var id: String {
        guard let id = data["results"][0]["id"].string else { return "" }
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
    public var details: [Detail] {
        var details = [Detail]()
        for (_, result):(String,JSON) in data {
            let detailsDeserializer = DetailsDeserializer(result)
            details.append(detailsDeserializer.detail)
        }
        return details
    }
    
    
}

public struct DetailsDeserializer {
    private var data: JSON
    
    public init(_ data: JSON) {
        self.data = data
    }
    public var detail: Detail {
        return Detail(id, definition, register, examples, subDetails)
    }
    
    //Detail
    public var id: String {
        guard let id = data["id"].string else { return "" }
        return id
    }
    public var definition: String {
        guard let definition = data["definitions"][0].string else { return "" }
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





