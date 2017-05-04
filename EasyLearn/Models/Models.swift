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
    
    

    
    //Computed Properties
    public var lexicalCount: Int? {
        get {
            return lexicalEntries?.count
        }
    }
    var count: Int? {
        return details?.count
    }
    
}
public class Detail: WordPresentable {
    
    typealias DetailType = SubDetail
    var id: String?
    var definition: String?
    var register: String?
    var examples: [String]?
    var details: [DetailType]?
    
    var lexicalEntry: String = ""
    var word: String = ""
    
    var isWord: Bool = false
    var isDetail: Bool = true
    
    init() {
        
    }
    public init(_ id: String?, _ word: String, _ lexicalEntry: String, _ definition: String?, _ register: String?, _ examples: [String], _ subDetails: [SubDetail]) {
        self.id = id
        self.word = word
        self.definition = definition
        self.register = register
        self.examples = examples
        self.details = subDetails
        self.lexicalEntry = lexicalEntry
    }
    var count: Int? {
        return details?.count
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
    

    
}
public class SubDetail {
    
    var id: String?
    var definition: String?
    var register: String?
    var examples: [String]?
    
}
    

protocol WordPresentable {
    associatedtype DetailType
    var isWord: Bool { get set }
    var isDetail: Bool { get set }
    var lexicalEntry: String { get set }
    var word: String { get set }
    var count: Int? { get }
    
    func getRegister(at indexPath: IndexPath) -> String?
    func getDefinition(at indexPath: IndexPath) -> String?
    func getExamples(at indexPath: IndexPath) -> [String]?
    func getWordID(at indexPath: IndexPath) -> String?
    func getCount(at indexPath: IndexPath) -> Int?
    func getDetail(at indexPath: IndexPath) -> Detail?
    
}




