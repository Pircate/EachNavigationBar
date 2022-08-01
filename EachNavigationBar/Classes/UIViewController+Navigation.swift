//
//  UIViewController+Navigation.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension UIViewController: NavigationCompatible {}

public extension Navigation where Base: UIViewController {
    
    var bar: EachNavigationBar {
        return base._navigationBar
    }
    
    var item: UINavigationItem {
        return base._navigationItem
    }
}

public extension Navigation where Base: UINavigationController {
    
    var configuration: UINavigationController.Configuration {
        return base._configuration
    }
}
