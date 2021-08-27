//
//  Location.swift
//  MapsGB
//
//  Created by Alexander Novikov on 27.08.2021.
//

import Foundation
import CoreLocation
import RealmSwift

class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
    }
}
