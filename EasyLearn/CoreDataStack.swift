//
//  CoreDataStack.swift
//  Kaftan
//
//  Created by Tebeen on 1/21/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()
    
    //MARK:- default Core Data methods
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print(urls)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "CDWord", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            //1
            let storeType = NSSQLiteStoreType //NSInMemoryStoreType
            
            try coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: - Contexts
    lazy var mainContext: NSManagedObjectContext = {
        
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return mainContext
    }()
    
    
}

extension NSManagedObjectContext {
    func trySave() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                let nserror = error as NSError
                NSLog("🐍Unable to save context: unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        } else {
            print("❗️Unable to save context: no changes found")
        }
    }
}

