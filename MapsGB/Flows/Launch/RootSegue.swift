//
//  RootSegue.swift
//  MapsGB
//
//  Created by Alexander Novikov on 31.08.2021.
//

import UIKit

class RootSegue: UIStoryboardSegue {
    override func perform() {
        UIWindow.keyWindow?.rootViewController = destination
    }
}


