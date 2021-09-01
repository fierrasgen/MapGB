//
//  MainViewController.swift
//  MapsGB
//
//  Created by Alexander Novikov on 31.08.2021.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    @IBAction func showMap(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        performSegue(withIdentifier: "toLAunch", sender: sender)
    }
}
