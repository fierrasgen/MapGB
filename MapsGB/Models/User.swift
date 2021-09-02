//
//  User.swift
//  MapsGB
//
//  Created by Alexander Novikov on 02.09.2021.
//

import Foundation
import RealmSwift


class User: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "login"
    }
    
    convenience init(login: String, password: String) {
        self.init()
        
        self.login = login
        self.password = password
    }
}


