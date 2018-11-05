//
//  AppDelegate.swift
//  EachNavigationBar
//
//  Created by Pircate on 04/19/2018.
//  Copyright (c) 2018 Pircate. All rights reserved.
//

import UIKit
import EachNavigationBar

#if swift(>=4.2)
typealias ApplicationLaunchOptionsKey = UIApplication.LaunchOptionsKey
#else
typealias ApplicationLaunchOptionsKey = UIApplicationLaunchOptionsKey
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [ApplicationLaunchOptionsKey: Any]?) -> Bool {
        // setup
        UIViewController.navigation.swizzle()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: MainViewController())
        // config
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.barTintColor = UIColor.yellow
        nav.navigation.configuration.backImage = #imageLiteral(resourceName: "back")
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}

