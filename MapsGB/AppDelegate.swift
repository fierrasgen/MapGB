//
//  AppDelegate.swift
//  MapsGB
//
//  Created by Alexander Novikov on 24.08.2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var visualEffectView = UIVisualEffectView()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyB9gfRhEKbpQK-1n0s0uJXZZ7OIzbLXyVQ")
        return true
    }

    // MARK: UISceneSession Lifecycle
    
//    var window: UIWindow?
//    var blurViewTag: Int {
//            return 999999
//        }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = window!.frame
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.tag = blurViewTag
//
//
//
//        self.window?.addSubview(blurEffectView)
//       }
//
//       func applicationDidBecomeActive(_ application: UIApplication) {
//        self.window?.viewWithTag(blurViewTag)?.removeFromSuperview()
//       }
//   }
//

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    var window: UIWindow?

        func applicationWillResignActive(_ application: UIApplication) {
            addBlurViews()
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            removeBlurViews()
        }
    }

    private extension AppDelegate {
        var blurViewTag: Int {
            return 999999
        }

        func addBlurViews() {
            for window in UIApplication.shared.windows {
                let blurEffect: UIBlurEffect
                if #available(iOS 14.0, *) {
                    blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                } else {
                    blurEffect = UIBlurEffect(style: .light)
                }
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = window.frame
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                blurEffectView.tag = blurViewTag
                window.addSubview(blurEffectView)
            }
        }

        func removeBlurViews() {
            for window in UIApplication.shared.windows {
                if let blurView = window.viewWithTag(blurViewTag) {
                    blurView.removeFromSuperview()
                }
            }
        }
    }




