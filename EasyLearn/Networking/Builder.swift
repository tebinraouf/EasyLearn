//
//  Builder.swift
//  EasyLearn
//
//  Created by Tebeen on 4/29/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


/*
 - Build a word model from json data
 */

class Builder {
    func wordFromData(_ data: JSON?) -> Word? {
        guard let data = data else { return nil }
        let deserializer = WordDeserializer(data: data)
        let wordCreator = WordCreator(deserializer)
        let word = wordCreator.create
        return word
    }
}
