//
//  UIViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import ObjectiveC

// MARK: - Public
extension UIViewController {
    
    public static let setupNavigationBar: Void = {
        selector_exchangeImplementations(#selector(viewDidLoad), #selector(each_viewDidLoad))
        selector_exchangeImplementations(#selector(viewWillAppear(_:)), #selector(each_viewWillAppear(_:)))
        selector_exchangeImplementations(#selector(setNeedsStatusBarAppearanceUpdate), #selector(each_setNeedsStatusBarAppearanceUpdate))
    }()
    
    @objc public var each_navigationBar: EachNavigationBar {
        if let bar = objc_getAssociatedObject(self, &AssociatedKeys.navigationBar) as? EachNavigationBar {
            return bar
        }
        let bar = EachNavigationBar(self)
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBar, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    @objc public var each_navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(self, &AssociatedKeys.navigationItem) as? UINavigationItem {
            return item
        }
        let item = UINavigationItem()
        objc_setAssociatedObject(self, &AssociatedKeys.navigationItem, item, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
    
    @objc public static func swizzle_setupNavigationBar() {
        setupNavigationBar
    }
    
    @objc public func adjustsNavigationBarPosition() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        each_navigationBar.frame = navigationBar.frame
        each_navigationBar.frame.size.height += each_navigationBar.extraHeight
        each_navigationBar.setNeedsLayout()
    }
}

// MARK: - Swizzle
extension UIViewController {
    
    private static func selector_exchangeImplementations(_ sel1: Selector, _ sel2: Selector) {
        if let originalMethod = class_getInstanceMethod(UIViewController.self, sel1),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, sel2) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    private var asTableViewController: UITableViewController? {
        return self as? UITableViewController
    }
    
    @objc private func each_viewDidLoad() {
        each_viewDidLoad()
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        bindNavigationBar()
        asTableViewController?.addObserverIfViewIsTableView()
    }
    
    @objc private func each_viewWillAppear(_ animated: Bool) {
        each_viewWillAppear(animated)
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        bringNavigationBarToFront()
        asTableViewController?.adjustsTableViewContentInset()
    }
    
    @objc private func each_setNeedsStatusBarAppearanceUpdate() {
        each_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarPosition()
    }
}

// MARK: - Configure each navigation bar
extension UIViewController {
    
    private func bindNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.isHidden = true
        setupNavigationBarStyle()
        setupBackBarButtonItem()
        view.addSubview(each_navigationBar)
    }
    
    private func bringNavigationBarToFront() {
        #if swift(>=4.2)
        view.bringSubviewToFront(each_navigationBar)
        #else
        view.bringSubview(toFront: each_navigationBar)
        #endif
    }
    
    private func setupNavigationBarStyle() {
        guard let configuration = navigationController?.navigation.configuration else { return }
        each_navigationBar.isHidden = configuration.isHidden
        each_navigationBar.alpha = configuration.alpha
        each_navigationBar.barTintColor = configuration.barTintColor
        each_navigationBar.shadowImage = configuration.shadowImage
        each_navigationBar.titleTextAttributes = configuration.titleTextAttributes
        each_navigationBar.setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        each_navigationBar.isTranslucent = configuration.isTranslucent
        each_navigationBar.barStyle = configuration.barStyle
        each_navigationBar.extraHeight = configuration.extraHeight
    }
    
    private func setupBackBarButtonItem() {
        guard let navigationController = navigationController,
            navigationController.viewControllers.count > 1,
            let image = navigationController.navigation.configuration.backImage else { return }
        each_navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backAction))
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
