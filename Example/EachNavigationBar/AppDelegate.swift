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
        nav.navigation.configuration.barTintColor = UIColor.green
        nav.navigation.configuration.tintColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            nav.navigation.configuration.prefersLargeTitles = true
            nav.navigation.configuration.largeTitle.displayMode = .never
        }
        
        let shadow = Shadow(
            color: UIColor.black.cgColor,
            opacity: 0.5,
            offset: CGSize(width: 0, height: 3)
        )
        nav.navigation.configuration.shadow = shadow
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

