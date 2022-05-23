//
//  UIViewController+Swizzling.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

infix operator <=>

extension UIViewController {
    
    static let methodSwizzling: Void = {
        #selector(viewDidLoad) <=> #selector(navigation_viewDidLoad)
        #selector(viewWillAppear(_:)) <=> #selector(navigation_viewWillAppear(_:))
        #selector(setNeedsStatusBarAppearanceUpdate) <=> #selector(navigation_setNeedsStatusBarAppearanceUpdate)
        #selector(viewDidLayoutSubviews) <=> #selector(navigation_viewDidLayoutSubviews)
    }()
    
    private var isNavigationBarEnabled: Bool {
        guard let navigationController = navigationController,
              navigationController.navigation.configuration.isEnabled,
              navigationController.viewControllers.contains(self) else {
            return false
        }
        
        return true
    }
    
    @objc private func navigation_viewDidLoad() {
        navigation_viewDidLoad()
        
        guard isNavigationBarEnabled else { return }
        
        setupNavigationBarWhenViewDidLoad()
        
        if let tableViewController = self as? UITableViewController {
            tableViewController.observeContentOffset()
        }
    }
    
    @objc private func navigation_viewWillAppear(_ animated: Bool) {
        navigation_viewWillAppear(animated)
        
        guard isNavigationBarEnabled else { return }
        
        updateNavigationBarWhenViewWillAppear()
    }
    
    @objc private func navigation_setNeedsStatusBarAppearanceUpdate() {
        navigation_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarLayout()
    }
    
    @objc private func navigation_viewDidLayoutSubviews() {
        navigation_viewDidLayoutSubviews()
        
        view.bringSubviewToFront(_navigationBar)
    }
}

private extension Selector {
    
    static func <=> (left: Selector, right: Selector) {
        UIViewController.swizzled_method(left, right)
    }
}

fileprivate extension NSObject {
    
    static func swizzled_method(_ originalSelector: Selector, _ swizzledSelector: Selector) {
        guard
            let originalMethod = class_getInstanceMethod(Self.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(Self.self, swizzledSelector) else {
            return
        }
        
        // 在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(
            Self.self,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        // 如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(
                Self.self,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
