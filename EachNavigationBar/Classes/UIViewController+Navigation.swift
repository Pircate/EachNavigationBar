//
//  UIViewController+Navigation.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

public extension Navigation where Base: UIViewController {
    
    var bar: EachNavigationBar {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationBar
    }
    
    var item: UINavigationItem {
        assert(!(base is UINavigationController),
               "UINavigationController can't use this property, please use configuration.")
        return base._navigationItem
    }
}

public extension Navigation where Base: UINavigationController {
    
    var configuration: Configuration {
        return base._configuration
    }
    
    @available(iOS 11.0, *)
    func prefersLargeTitles() {
        base.navigationBar.prefersLargeTitles = true
    }
}
