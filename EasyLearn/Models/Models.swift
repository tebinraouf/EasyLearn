//
//  Models.swift
//  EasyLearn
//
//  Created by Tebeen on 3/4/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Word: WordPresentable {
    typealias DetailType = Detail


    private var _id: String?
    private var _lexicalEntries: [String]?
    var details: [DetailType]?
    
    private var _word: String = ""
    private var _lexicalEntry: String = ""
    var isWord: Bool = true
    var isDetail: Bool = false
    
    //MARK: Main Word Getters & Setters
    public var id: String? {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    public var word: String {
        get {
            return _word
        }
        set {
            _word = newValue
        }
    }
    public var lexicalEntries: [String]? {
        get {
            return _lexicalEntries
        }
        set {
            _lexicalEntries = newValue
        }
    }
    public var lexicalEntry: String {
        get {
            return _lexicalEntry
        }
        set {
            _lexicalEntry = newValue
        }
    }
    
    
    

    //Word Detail Getters
    public func getWordID(at indexPath: IndexPath) -> String? {
        guard let id = details?[indexPath.item].id else { return nil }
        return id
    }
    public func getExamples(at indexPath: IndexPath) -> [String]? {
        guard let examples = details?[indexPath.item].examples else { return nil }
        return examples
    }
    public func getRegister(at indexPath: IndexPath) -> String? {
        guard let register = details?[indexPath.item].register else { return nil }
        return register
    }
    public func getDefinition(at indexPath: IndexPath) -> String? {
        guard let definition = details?[indexPath.item].definition else { return nil }
        return definition
    }
    public func getSubDetails(at indexPath: IndexPath) -> [SubDetail]? {
        guard let subs = details?[indexPath.item].details else { return nil }
        return subs
    }
    public func getCount(at indexPath: IndexPath) -> Int? {
        guard let count = details?[indexPath.item].count else { return nil }
        return count
    }
    public func getDetail(at indexPath: IndexPath) -> Detail? {
        return details?[indexPath.item]
    }
    //the pronunciation is the same either for word or details
    public func getPronunciation() -> [Pronunciation]? {
        return details?[0].getPronunciation()
    }
    
    

    
    //Computed Properties
    public var lexicalCount: Int {
        return lexicalEntries?.count ?? 0
    }
    var count: Int {
        return details?.count ?? 0
    }
    
}
public class Detail: WordPresentable {
    
    typealias DetailType = SubDetail
    var id: String?
    var definition: String?
    var register: String?
    var examples: [String]?
    var details: [DetailType]?
    var pronunciations: [Pronunciation]?
    
    
    
    var lexicalEntry: String = ""
    var word: String = ""
    
    var isWord: Bool = false
    var isDetail: Bool = true
    
    init() {
        
    }
    public init(_ id: String?, _ word: String, _ lexicalEntry: String, _ definition: String?, _ register: String?, _ examples: [String], _ subDetails: [SubDetail], _ pronunciations: [Pronunciation]) {
        self.id = id
        self.word = word
        self.definition = definition
        self.register = register
        self.examples = examples
        self.details = subDetails
        self.lexicalEntry = lexicalEntry
        self.pronunciations = pronunciations
    }
    var count: Int {
        return details?.count ?? 0
    }
    
    
    
    public func getWordID(at indexPath: IndexPath) -> String? {
        guard let id = details?[indexPath.item].id else { return nil }
        return id
    }
    public func getExamples(at indexPath: IndexPath) -> [String]? {
        guard let examples = details?[indexPath.item].examples else { return nil }
        return examples
    }
    public func getRegister(at indexPath: IndexPath) -> String? {
        guard let register = details?[indexPath.item].register else { return nil }
        return register
    }
    public func getDefinition(at indexPath: IndexPath) -> String? {
        guard let definition = details?[indexPath.item].definition else { return nil }
        return definition
    }
    func getCount(at indexPath: IndexPath) -> Int? {
        return 0
    }
    func getDetail(at indexPath: IndexPath) -> Detail? {
        return nil
    }
    func getPronunciation() -> [Pronunciation]? {
        return pronunciations
    }
    
}
public class SubDetail {
    var id: String?
    var definition: String?
    var register: String?
    var examples: [String]?
}

public struct Pronunciation {
    var dialects: String?
    var phoneticSpelling: String?
    var audioFile: String?
    var phoneticNotation: String?

    

}



protocol WordPresentable {
    associatedtype DetailType
    var isWord: Bool { get set }
    var isDetail: Bool { get set }
    var lexicalEntry: String { get set }
    var word: String { get set }
    var count: Int { get }
    
    func getRegister(at indexPath: IndexPath) -> String?
    func getDefinition(at indexPath: IndexPath) -> String?
    func getExamples(at indexPath: IndexPath) -> [String]?
    func getWordID(at indexPath: IndexPath) -> String?
    func getCount(at indexPath: IndexPath) -> Int?
    func getDetail(at indexPath: IndexPath) -> Detail?
    func getPronunciation() -> [Pronunciation]?
    
}




