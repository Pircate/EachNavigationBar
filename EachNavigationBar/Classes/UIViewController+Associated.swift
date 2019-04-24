// 
//  UIViewController+Associated.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

import ObjectiveC

extension UINavigationController {
    
    var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(
            self,
            &AssociatedKeys.configuration)
            as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.configuration,
            configuration,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}

extension UIViewController {
    
    var _navigationBar: EachNavigationBar {
        if let bar = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationBar)
            as? EachNavigationBar {
            return bar
        }
        let bar = EachNavigationBar(viewController: self)
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationBar,
            bar,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationItem)
            as? UINavigationItem {
            return item
        }
        
        #if swift(<5)
        let item: UINavigationItem
        if let navigationItem = try? navigationItem.duplicate() {
            item = navigationItem ?? UINavigationItem()
        } else {
            item = UINavigationItem()
        }
        #else
        let item = (try? navigationItem.duplicate()) ?? UINavigationItem()
        #endif
        
        item.copyTargetActions(from: navigationItem)
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationItem,
            item,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
}

private extension UINavigationItem {
    
    func copyTargetActions(from navigationItem: UINavigationItem) {
        if let leftBarButtonItems = navigationItem.leftBarButtonItems,
            let leftItems = self.leftBarButtonItems,
            leftBarButtonItems.count == leftItems.count {
            leftItems.enumerated().forEach {
                $0.element.target = leftBarButtonItems[$0.offset].target
                $0.element.action = leftBarButtonItems[$0.offset].action
            }
        }
        
        if let rightBarButtonItems = navigationItem.rightBarButtonItems,
            let rightItems = self.rightBarButtonItems,
            rightBarButtonItems.count == rightItems.count {
            rightItems.enumerated().forEach {
                $0.element.target = rightBarButtonItems[$0.offset].target
                $0.element.action = rightBarButtonItems[$0.offset].action
            }
        }
    }
}
