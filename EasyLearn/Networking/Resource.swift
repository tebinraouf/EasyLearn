//
//  Resource.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

enum Status {
    case Success
    case NotFound
}

enum OxfordFilters: String {
    case lexicalCategory
    case definitions
    case domains
    case etymologies
    case examples
    case grammaticalFeatures
    case pronunciations
    case regions
    case registers
    case variantForms
}

class Resource {
    private let language = "en"
    private let appId = "0edbffb4"
    private let appKey = "e37ace6aa056552f46837f02bd5f0ced"
    private var url: String
    
    public init(_ url: String) {
        self.url = url
    }
    public init(_ url: String, _ word: String, _ filters: [OxfordFilters]) {
        self.url = url
        self.setURL(url, word, filters)
    }
    public init(_ url: String, _ word: String, _ lexicalCategory: String, _ filters: [OxfordFilters]) {
        self.url = url + word.lowercased().trimmingCharacters(in: CharacterSet.whitespaces) + "/lexicalCategory=" + lexicalCategory
        filters.forEach { (filter) in
            self.url.append(";")
            let f = filter.rawValue
            self.url.append(f)
        }
        
    }
    public init(_ url: String, _ domain: String) {
        self.url = url + domain
    }
    private func setURL(_ url: String, _ word: String, _ filters: [OxfordFilters]) {
        self.url = url + word.lowercased().trimmingCharacters(in: CharacterSet.whitespaces) + "/"
        
        var i = 0
        filters.forEach { (filter) in
            let f = filter.rawValue
            self.url.append(f)
            while i < filters.count - 1 {
                self.url.append("/")
                i += 1
            }
        }
    }
    public var request: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        return request
    }
    func load(completion: @escaping (JSON?, Status)->()) {
        let session = URLSession.shared
        guard let request = request else { return }
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let result = JSON(data: data)
            guard let response = response as? HTTPURLResponse else  { return }
            
            switch response.statusCode {
            case 200:
                completion(result, .Success)
            case 404:
                completion(nil, .NotFound)
            default: break
            }
            }.resume()
    }
}
