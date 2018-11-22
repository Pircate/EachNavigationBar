// 
//  UIViewController+Swizzling.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UIViewController {
    
    private static func selector_exchangeImplementations(_ sel1: Selector, _ sel2: Selector) {
        if let originalMethod = class_getInstanceMethod(UIViewController.self, sel1),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, sel2) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public static func each_methodSwizzling() {
        method_swizzling
    }
    
    private static let method_swizzling: Void = {
        selector_exchangeImplementations(#selector(viewDidLoad), #selector(each_viewDidLoad))
        selector_exchangeImplementations(
            #selector(viewWillAppear(_:)),
            #selector(each_viewWillAppear(_:)))
        selector_exchangeImplementations(
            #selector(setNeedsStatusBarAppearanceUpdate),
            #selector(each_setNeedsStatusBarAppearanceUpdate))
    }()
    
    @objc private func each_viewDidLoad() {
        each_viewDidLoad()
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        setupNavigationBarWhenViewDidLoad()
        
        if let tableViewController = self as? UITableViewController {
            tableViewController.addObserverForContentOffset()
        }
    }
    
    @objc private func each_viewWillAppear(_ animated: Bool) {
        each_viewWillAppear(animated)
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        updateNavigationBarWhenViewWillAppear()
    }
    
    @objc private func each_setNeedsStatusBarAppearanceUpdate() {
        each_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarPosition()
    }
}
