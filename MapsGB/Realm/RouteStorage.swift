//
//  RouteStorage.swift
//  MapsGB
//
//  Created by Alexander Novikov on 27.08.2021.
//

import Foundation
import RealmSwift


class RouteStorage {
    
    static var shared = RouteStorage()
    
    private var realm = try! Realm()
    
    private init() {  }

    
    func saveLastRoute(route: [Location]) {
        clearLastRoute()
        try? realm.write {
            realm.add(route)
        }
    }

    func loadLastRoute() -> Results<Location> {
        return realm.objects(Location.self)
    }

    func clearLastRoute() {
        let result = realm.objects(Location.self)
        try? realm.write {
            realm.delete(result)
        }
    }
}
