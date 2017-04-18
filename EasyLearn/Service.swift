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

enum Header: String {
    case language = "en"
    case appId = "0edbffb4"
    case appKey = "e37ace6aa056552f46837f02bd5f0ced"
}
class Service {
    static let sharedInstance = Service()
    func headers(word: String, urlString: String) -> URLRequest? {
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
        let request = headers(word: word, urlString: url)
        let session = URLSession.shared
        
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            if error == nil {
                guard let data = data else { return }
                let result = JSON(data: data)
                
                DispatchQueue.main.async {
                    let word = self.createWord(from: result)
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
        let request = headers(word: word, urlString: url)
        let session = URLSession.shared
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            guard let data = data else { return }
            let jsonData = JSON(data: data)
            let results = jsonData["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]
            
            if error == nil {
                DispatchQueue.main.async {
                    var details = [Detail]()
                    for (_, result):(String,JSON) in results {
                        let examples = self.examples(from: result)
                        let subDetails = self.subDetails(from: result)
                        details.append(self.detail(examples, subDetails, result))
                    }
                    completion(details, nil)
                }
            } else {
                completion(nil, error)
            }
        })
        result.resume()
    }
    fileprivate func subDetails(from result: JSON) -> [SubDetail] {
        var subDetails = [SubDetail]()
        for (index, _) in result["subsenses"].enumerated() {
            let subDetail = SubDetail()
            
            //sub 1 word ID
            if let subWordId = result["subsenses"][index]["id"].string {
                subDetail.subWordId = subWordId
            }
            
            
            //sub 2 word definition
            if let subDefinition = result["subsenses"][index]["definitions"][0].string {
                subDetail.subDefinition = subDefinition
            }
            
            //sub 3 word examples
            var subExamples = [String]()
            for (subIndex, _) in result["subsenses"][index]["examples"].enumerated() {
                var subEachExample = String()
                if let subExample = result["subsenses"][index]["examples"][subIndex]["text"].string {
                    subEachExample = subExample
                }
                subExamples.append(subEachExample)
            }
            subDetail.subExamples = subExamples
            
            //sub 4 word register
            if let subRegister = result["subsenses"][index]["registers"][0].string {
                subDetail.subRegister = subRegister
            }
            subDetails.append(subDetail)
        }
        return subDetails
    }
    fileprivate func examples(from result: JSON) -> [String] {
        var examples = [String]()
        for (index, _) in result["examples"].enumerated() {
            var eachExample = String()
            if let example = result["examples"][index]["text"].string {
                eachExample = example
            }
            examples.append(eachExample)
        }
        return examples
    }
    fileprivate func detail(_ examples: [String], _ subDetails: [SubDetail], _ result: JSON) -> Detail {
        
        //Detail 1: ID
        //Detail 2: Definition
        //Detail 3: examples
        //Detail 4: sub details
        //Detail 5: register (formal or informal)
        
        let detail = Detail()
        detail.wordId = result["id"].string
        detail.definition = result["definitions"][0].string
        detail.examples = examples
        detail.subdetails = subDetails
        detail.register = result["registers"][0].string
        return detail
    }
    fileprivate func createWord(from result: JSON) -> Word {
        func getLexicalCategory() -> [String] {
            var lexicalEntriesArray = [String]()
            let lexicalEntries = result["results"][0]["lexicalEntries"]
            for (_, lexicalEntry):(String, JSON) in lexicalEntries {
                if let lexicalEntry = lexicalEntry["lexicalCategory"].string {
                    lexicalEntriesArray.append(lexicalEntry)
                }
            }
            return lexicalEntriesArray
        }
        let word = Word()
        word.word = result["results"][0]["word"].string
        word.id = result["results"][0]["id"].string
        word.lexicalEntries = getLexicalCategory()
        return word
    }
    
}
