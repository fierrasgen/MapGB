//
//  UiWindow + keyWindow.swift
//  MapsGB
//
//  Created by Alexander Novikov on 01.09.2021.
//

import Foundation
import UIKit

extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate {
                return delegate.window
            }
        } else {
            return UIApplication.shared.keyWindow
        }
        return nil
    }
}
