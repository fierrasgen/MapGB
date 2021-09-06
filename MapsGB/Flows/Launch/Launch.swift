//
//  Launch.swift
//  MapsGB
//
//  Created by Alexander Novikov on 31.08.2021.
//

import Foundation
import UIKit

class Launch: UIViewController {
    
    @IBOutlet var router: LaunchRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "isLogin") {
            router.toMain()
        } else {
            router.toAuth()
        }
    }
}

final class LaunchRouter: BaseRouter {
    
    func toMain() {
        perform(segue: "toMain")
    }
    
    func toAuth() {
        perform(segue: "toAuth")
    }
}
