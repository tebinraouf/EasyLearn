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
    
}




class ColorCoreDataLayer {
    let mainContext = CoreDataStack.sharedInstance.mainContext
    //Color Model
    lazy var numberOfColors: Int = {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        let count = try! self.mainContext.count(for: fetchRequest)
        return count
    }()
    init() {
        if numberOfColors <= 0 {
            addColor(rgb: (r: 255, g: 255, b: 255))
            addColor(rgb: (r: 0, g: 0, b: 0))
        }
    }
    func fetchColors() -> [Color]? {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        let colors = try? mainContext.fetch(fetchRequest)
        return colors
    }
    func addColor(rgb: (r: Int, g: Int, b: Int)) {
        let color = Color(context: mainContext)
        color.red = Float(rgb.r)
        color.green = Float(rgb.g)
        color.blue = Float(rgb.b)
        mainContext.trySave()
    }
}









