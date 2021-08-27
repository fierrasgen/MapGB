//
//  UiAlert.swift
//  MapsGB
//
//  Created by Alexander Novikov on 27.08.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { action in
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
