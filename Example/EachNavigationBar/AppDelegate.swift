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
        nav.navigation.configuration.backBarButtonItem = .init(style: .image(UIImage(named: "back")), tintColor: UIColor.blue)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

