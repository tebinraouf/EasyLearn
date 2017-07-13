//
//  FirebaseHelper.swift
//  EasyLearn
//
//  Created by Tebin on 7/11/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import Foundation
import Firebase


class FirebaseHelper {
    var ref: FIRDatabaseReference!
    init() {
        ref = FIRDatabase.database().reference()
    }
    func getMonth(_ result: @escaping (Int)->()) {
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let month = value?["month"] as? Int {
                monthCheck = month
                result(monthCheck)
            } else {
                result(0)
            }
        })
    }
    func getYear(_ yearValue: @escaping (Int)->()) {
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let year = value?["year"] as? Int {
                yearCheck = year
                yearValue(yearCheck)
            } else {
                yearValue(0)
            }
        })
    }
    func getSearchLimit(_ searchLimit: @escaping (Int)->()) {
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let limit = value?["searchLimit"] as? Int {
                searchLimitCount = limit
                searchLimit(searchLimitCount)
            } else {
                searchLimit(0)
            }
        })
    }
    func getIsUpdated(_ isUpdated: @escaping (Int)-> ()) {
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let isUpdatedValue = value?["isUpdated"] as? Int {
                isSearchLimitUpdated = isUpdatedValue
                isUpdated(isSearchLimitUpdated)
            } else {
                isUpdated(0)
            }
        })
    }
    func updateFirebase(_ firebaseValues: @escaping (Int, Int, Int, Int)-> ()) {
        getMonth { (month) in
            self.getIsUpdated({ (isUpdated) in
                self.getYear({ (year) in
                    self.getSearchLimit({ (searchLimit) in
                        firebaseValues(searchLimit, month, year, isUpdated)
                    })
                    
                })
            })
        }
    }
    func checkUserLimit() {
        
        updateFirebase { (searchLimit, month, year, isUpdated) in
            //initial setup
            if searchLimit == 0 && month == 0 && year == 0 && isUpdated == 0 {
                searchLimitCount = 30
                monthCheck = Date().getCurrentMonth()
                yearCheck = Date().getCurrentYear()
                isSearchLimitUpdated = 1
                self.updateFirebaseDatabase()
            } else if Date().getCurrentYear() > year {
                //new year
                searchLimitCount = 30
                monthCheck = Date().getCurrentMonth()
                yearCheck = Date().getCurrentYear()
                isSearchLimitUpdated = 1
                self.updateFirebaseDatabase()
            } else if Date().getCurrentMonth() > month && isUpdated == 0 {
                // new month
                searchLimitCount = 30
                monthCheck = Date().getCurrentMonth()
                isSearchLimitUpdated = 1
                self.updateFirebaseDatabase()
            } else if searchLimitCount == 0 && monthCheck == 0 && yearCheck == 0 && isSearchLimitUpdated == 0 {
                //new install in a new phone
                searchLimitCount = searchLimit
                monthCheck = month
                yearCheck = year
                isSearchLimitUpdated = isUpdated
                self.updateFirebaseDatabase()
            } else {
                // reset isUpdated to 0
                isSearchLimitUpdated = 0
                self.updateFirebaseDatabase()
            }
            
        }
    }
    func updateFirebaseDatabase() {
        ref.child("users").child(userID).setValue(["searchLimit": searchLimitCount, "isUpdated": isSearchLimitUpdated, "month": monthCheck, "year": yearCheck])
    }
}
