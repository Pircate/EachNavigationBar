// 
//  UIViewController+Associated.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

import ObjectiveC
import UIKit

extension UINavigationController {
    
    var _configuration: Configuration {
        let config = withUnsafePointer(to: &AssociatedKeys.configuration) {
            objc_getAssociatedObject(self, $0) as? Configuration
        }
        
        if let config  {
            return config
        }
        
        let configuration = Configuration()
        
        withUnsafePointer(to: &AssociatedKeys.configuration) {
            objc_setAssociatedObject(
                self,
                $0,
                configuration,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        
        return configuration
    }
}

extension UIViewController {
    
    var _navigationBar: EachNavigationBar {
        let bar = withUnsafePointer(to: &AssociatedKeys.navigationBar) {
            objc_getAssociatedObject(self, $0) as? EachNavigationBar
        }
        
        if let bar {
            return bar
        }
        
        let navigationBar = EachNavigationBar(viewController: self)
        
        withUnsafePointer(to: &AssociatedKeys.navigationBar) {
            objc_setAssociatedObject(
                self,
                $0,
                navigationBar,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        
        return navigationBar
    }
    
    var _navigationItem: EachNavigationItem {
        let item = withUnsafePointer(to: &AssociatedKeys.navigationItem) {
            objc_getAssociatedObject(self, $0) as? EachNavigationItem
        }
        
        if let item  {
            return item
        }
        
        let navigationItem = EachNavigationItem(viewController: self)
        navigationItem.copy(by: navigationItem)
        
        withUnsafePointer(to: &AssociatedKeys.navigationItem) {
            objc_setAssociatedObject(
                self,
                $0,
                navigationItem,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        
        return navigationItem
    }
}

private extension UINavigationItem {
    
    func copy(by navigationItem: UINavigationItem) {
        self.title = navigationItem.title
        self.prompt = navigationItem.prompt
    }
}
