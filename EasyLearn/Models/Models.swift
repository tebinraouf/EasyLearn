//
//  Models.swift
//  EasyLearn
//
//  Created by Tebeen on 3/4/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation

class WordWord {
    private var language: String?
    private var id: String?
    private var word: String?
    private var type: String?
    private var lexicalEntries: [String]?
    private var details: [DetailDetail]?
    
    public init(_ language: String, id: String, word: String, type: String) {
        self.language = language
        self.id = id
        self.word = word
        self.type = type
    }
    //MARK: Main Word Setters
    public func setLexicalEntries(_ entries: [String]) {
        self.lexicalEntries = entries
    }
    
    
//    //MARK: Main Word Getters
//    public func getID(at indexPath: IndexPath) -> String {
//        guard let id = details?[indexPath.item].wordId else { return "" }
//        return id
//    }
//    public func getExamples(at indexPath: IndexPath) -> [String] {
//        guard let examples = details?[indexPath.item].examples else { return [""] }
//        return examples
//    }
//    public func getRegister(at indexPath: IndexPath) -> String {
//        guard let register = details?[indexPath.item].register else { return "" }
//        return register
//    }
//    public func getDefinition(at indexPath: IndexPath) -> String {
//        guard let definition = details?[indexPath.item].definition else { return "" }
//        return definition
//    }
    //MARK: Sub Word Getters
    
    
    
    //MARK: Main Word Computed Properties
    public var lexicalCount: Int {
        get {
            guard let count = lexicalEntries?.count else { return 0 }
            return count
        }
    }
    public var getLexicalEntries: [String] {
        get {
            guard let entries = lexicalEntries else { return [""] }
            return entries
        }
    }
    
    
}

class DetailDetail {
    var wordId: String?
    var definition: String?
    var examples: [String]?
    var register: String?
    var subdetails: [SubDetailSubDetail]?
}
class SubDetailSubDetail {
    var subWordId: String?
    var subDefinition: String?
    var subRegister: String?
    var subExamples: [String]?
}



public class Word: NSObject {
    private var _language: String?
    private var _id: String?
    private var _word: String?
    private var _type: String?
    private var _lexicalEntries: [String]?
    var details: [Detail]?
    
    private var _lexicalEntry: String = ""
    
    
    //MARK: Main Word Getters & Setters
    public var language: String? {
        get {
            return _language
        }
        set {
            _language = newValue
        }
    }
    public var id: String? {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    public var word: String? {
        get {
            return _word
        }
        set {
            _word = newValue
        }
    }
    public var type: String? {
        get {
            return _type
        }
        set {
            _type = newValue
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
        guard let id = details?[indexPath.item].wordId else { return nil }
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
        guard let subs = details?[indexPath.item].subDetails else { return nil }
        return subs
    }
    public func getSubCount(at indexPath: IndexPath) -> Int? {
        guard let count = details?[indexPath.item].subDetailsCount else { return nil }
        return count
    }
    public func getDetail(at indexPath: IndexPath) -> Detail? {
        return details?[indexPath.item]
    }
    
    

    
    //Computed Properties
    public var lexicalCount: Int? {
        get {
            return lexicalEntries?.count
        }
    }
    
}
public class Detail {
    var wordId: String?
    var definition: String?
    var register: String?
    var examples: [String]?
    var subDetails: [SubDetail]?
    
    
    init() {
        
    }
    public init(_ id: String?, _ definition: String?, _ register: String?, _ examples: [String], _ subDetails: [SubDetail]) {
        self.wordId = id
        self.definition = definition
        self.register = register
        self.examples = examples
        self.subDetails = subDetails
    }
    
    //Computed Properties
    public var subDetailsCount: Int? {
        get {
            return subDetails?.count
        }
    }
    
}
public class SubDetail {
    var subWordId: String?
    var subDefinition: String?
    var subRegister: String?
    var subExamples: [String]?
}
