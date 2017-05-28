//
//  DataLayerSimple.swift
//  Kaftan
//
//  Created by Tebeen on 1/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataLayerSimple {
    let mainContext = CoreDataStack.sharedInstance.mainContext
    lazy var numberOfResults: Int = {
        let fetchRequest: NSFetchRequest<CDWord> = CDWord.fetchRequest()
        let count = try! self.mainContext.count(for: fetchRequest)
        return count
    }()
    func saveWord(_ id: String?, _ lexicalEntry: String?, _ word: String?, _ examples: [String]?, _ definition: String?) {
        let cdWord = CDWord(context: mainContext)
        
        if let id = id {
            cdWord.id = id
        }
        
        if let lexicalEntry = lexicalEntry {
            cdWord.lexicalEntry = lexicalEntry
        }
        
        if let word = word {
            cdWord.word = word
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
    func isWordSavedWith(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<CDWord> = CDWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let words = try? mainContext.fetch(fetchRequest)
        if let _ = words?.first {
            return true
        } else {
            return false
        }
    }
    func removeWordBy(id: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDWord")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! self.mainContext.execute(deleteRequest)
        self.mainContext.reset()
    }
}



class DomainCoreData {
    let mainContext = CoreDataStack.sharedInstance.mainContext
    
    
    func saveDomain(_ name: String, key: String) {
        let cdDomain = CDDomain(context: mainContext)
        cdDomain.name = name
        cdDomain.key = key
        
        
        mainContext.trySave()
    }
    
    func fetchAllDomains() -> [CDDomain]? {
        //let sort = NSSortDescriptor(key: "id", ascending: true)
        let fetchRequest: NSFetchRequest<CDDomain> = CDDomain.fetchRequest()
        //fetchRequest.sortDescriptors = [sort]
        let domains = try? mainContext.fetch(fetchRequest)
        return domains
    }
    
    func removeManuallyCreatedDomains() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDDomain")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try! self.mainContext.execute(deleteRequest)
        self.mainContext.reset()
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
            
            addColor(rgb: (r: 255, g: 255, b: 255), alpha: 1, isCardColor: 1, isTextColor: 0, isViewColor: 0)
            addColor(rgb: (r: 0, g: 0, b: 0), alpha: 1, isCardColor: 0, isTextColor: 1, isViewColor: 0)
            addColor(rgb: (r: 255, g: 56, b: 63), alpha: 1, isCardColor: 0, isTextColor: 0, isViewColor: 1)
        }
    }
    func fetchColors() -> [Color]? {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        let colors = try? mainContext.fetch(fetchRequest)
        return colors
    }
    func addColor(rgb: (r: Int16, g: Int16, b: Int16), alpha: Double) {
        let color = Color(context: mainContext)
        color.red = Int16(rgb.r)
        color.green = Int16(rgb.g)
        color.blue = Int16(rgb.b)
        color.alpha = Double(String(format: "%.2f", alpha))!
        mainContext.trySave()
    }
    //TODO:- Use typealias
    //typealias rgb = (r: Int16, g: Int16, b: Int16)
    func addColor(rgb: (r: Int16, g: Int16, b: Int16), alpha: Double, isCardColor: Int16, isTextColor: Int16, isViewColor: Int16) {
        let color = Color(context: mainContext)
        color.red = Int16(rgb.r)
        color.green = Int16(rgb.g)
        color.blue = Int16(rgb.b)
        color.alpha = Double(String(format: "%.2f", alpha))!
        color.isCardColor = isCardColor
        color.isTextColor = isTextColor
        color.isViewColor = isViewColor
        mainContext.trySave()
    }
    
    //MARK: Card Background Color
    func saveDefaultColor(_ color: Color, for row: Int) {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "red == %D && green == %D && blue == %D", color.red, color.green, color.blue)

        if let colors = try? mainContext.fetch(fetchRequest) {
            for aColor in colors {
                
                switch row {
                case 0:
                    aColor.isCardColor = 1
                case 1:
                    aColor.isTextColor = 1
                case 2:
                    aColor.isViewColor = 1
                default:
                    break
                }
                
            }
        }
        mainContext.trySave()
    }
    func resetPreviousDefault(for row: Int) {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCardColor == 1 || isTextColor == 1 || isViewColor == 1")
        if let colors = try? mainContext.fetch(fetchRequest) {
            for color in colors {
                
                switch row {
                case 0:
                    color.isCardColor = 0
                case 1:
                    color.isTextColor = 0
                case 2:
                    color.isViewColor = 0
                default:
                    break
                }
                
            }
        }
    }
    func getColor(for property: String) -> Color? {
        let fetchRequest: NSFetchRequest<Color> = Color.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(property) == 1")
        if let colors = try? mainContext.fetch(fetchRequest) {
            if let color = colors.first {
                return color
            }
        }
        return nil
    }
}


class UserCoreDataLayer {
    let mainContext = CoreDataStack.sharedInstance.mainContext
    func add(_ user: User) {
        let cdUser = CDUser(context: mainContext)
        if !isUserSaved(email: user.email) {
            //print("New user")
            cdUser.name = user.name
            cdUser.email = user.email
            mainContext.trySave()
        }
    }
    func isUserSaved(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        if let users = try? mainContext.fetch(fetchRequest) {
            for user in users {
                if let cdEmail = user.email {
                    if cdEmail == email {
                        return true
                    }
                }
            }
        }
        return false
    }
}




