//
//  User.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userId: String?
    
    override class func primaryKey() -> String? {
        return "userId"
    }
}
