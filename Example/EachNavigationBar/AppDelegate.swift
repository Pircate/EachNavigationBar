//
//  AppDelegate.swift
//  EachNavigationBar
//
//  Created by Pircate on 04/19/2018.
//  Copyright (c) 2018 Pircate. All rights reserved.
//

import UIKit
import EachNavigationBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: MainViewController())
        // config
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.barTintColor = UIColor.yellow
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 44)
        nav.navigation.configuration.backBarButtonItem = .init(
            style: .custom(button),
            tintColor: UIColor.blue)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

