//
//  Service.swift
//  EasyLearn
//
//  Created by Tebeen on 3/9/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Service {
    
    
    let language = "en"
    
    static let sharedInstance = Service()
    
    func headers(word: String, urlString: String) -> URLRequest? {
        
        let appId = "0edbffb4"
        let appKey = "e37ace6aa056552f46837f02bd5f0ced"
        
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        return request
    }
    
    
    func initialSearch(word: String, completion: @escaping (Word?, Error?) -> ()) {
        
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/lexicalCategory"
        let request = headers(word: word, urlString: url)
        
        let session = URLSession.shared
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    guard let data = data else { return }
                    let jsonData = JSON(data: data)
                    //print(jsonData)
                    
                    let word = Word()
                    word.word = jsonData["results"][0]["word"].string
                    word.id = jsonData["results"][0]["id"].string
                    
                    var lexicalEntriesArray = [String]()
                    let lexicalEntries = jsonData["results"][0]["lexicalEntries"]
                    for lexicalEntry in lexicalEntries {
                        if let lexicalEntry = lexicalEntry.1["lexicalCategory"].string {
                            lexicalEntriesArray.append(lexicalEntry)
                        }
                    }
                    word.lexicalEntries = lexicalEntriesArray
                    
                    completion(word, nil)
                }else {
                    completion(nil, error)
                }
            }
        })
        
        result.resume()
        
    }
    
    
    func detailsFor(word: String, lexicalCategory: String ,completion: @escaping ([Detail]?, Error?) -> ()) {
        
        ////lexicalCategory=noun;examples;definitions
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/lexicalCategory=\(lexicalCategory);examples;definitions"
        let request = headers(word: word, urlString: url)
        
        
        let session = URLSession.shared
        let result = session.dataTask(with: request!, completionHandler: { data, response, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    guard let data = data else { return }
                    let jsonData = JSON(data: data)
                    print(jsonData)
                    
                    let results = jsonData["results"][0]["lexicalEntries"][0]["entries"][0]["senses"]
                    
                    var details = [Detail]()
                    for result in results {
                        
                        let detail = Detail()
                        
                        detail.wordId = result.1["id"].string
                        
                        if let definition = result.1["definitions"][0].string {
                            detail.definition = definition
                        }
                        var examples = [String]()
                        for (index, _) in result.1["examples"].enumerated() {
                            var eachExample = String()
                            if let example = result.1["examples"][index]["text"].string {
                                eachExample = example
                            }
                            examples.append(eachExample)
                        }
                        
                        detail.examples = examples
                        details.append(detail)
                        
                    }
                    
                    completion(details, nil)
                }else {
                    completion(nil, error)
                }
            }
        })
        
        result.resume()
        
    }
    
}
