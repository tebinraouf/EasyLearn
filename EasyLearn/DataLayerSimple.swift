//
//  DataLayerSimple.swift
//  Kaftan
//
//  Created by Tebeen on 1/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import CoreData

class DataLayerSimple {
    
    let mainContext = CoreDataStack.sharedInstance.mainContext
    
    lazy var numberOfResults: Int = {
        let fetchRequest: NSFetchRequest<CDWord> = CDWord.fetchRequest()
        let count = try! self.mainContext.count(for: fetchRequest)
        return count
    }()
    
    func saveWord(_ id: String?, _ language: String?, _ lexicalEntry: String?, _ word: String?, _ type: String?, _ examples: [String]?, _ definition: String?) {
        let cdWord = CDWord(context: mainContext)
        
        if let id = id {
            cdWord.id = id
        }
        
        if let language = language {
            cdWord.language = language
        }
        
        if let lexicalEntry = lexicalEntry {
            cdWord.lexicalEntry = lexicalEntry
        }
        
        if let word = word {
            cdWord.word = word
        }
        
        if let type = type {
            cdWord.type = type
        }
        
        if let examples = examples {
            
            var allExamples = String()
            for example in examples {
                allExamples.append("• ")
                allExamples.append(example)
                allExamples.append("\n")
            }
            
            cdWord.example = allExamples
        }
        
        if let definition = definition {
            cdWord.definition = definition
        }
        
        mainContext.trySave()
    }
    
    func fetchAllWords() -> [CDWord]? {
        let sort = NSSortDescriptor(key: "id", ascending: true)
        let fetchRequest: NSFetchRequest<CDWord> = CDWord.fetchRequest()
        fetchRequest.sortDescriptors = [sort]
        let words = try? mainContext.fetch(fetchRequest)
        return words
    }
    
    
    /*
 
     func fetchWords() -> [Word] {
     var favWordsReturn = [Word]()
     let sort = NSSortDescriptor(key: "id", ascending: true)
     let sortName = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
     
     let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
     fetchRequest.sortDescriptors = [sort, sortName]
     
     if let favWords = try? mainContext.fetch(fetchRequest) {
     favWordsReturn = favWords
     }
     return favWordsReturn
     }
 
     */
    
    
    
    
    
    
    
    
    
    
    
    
    
}
