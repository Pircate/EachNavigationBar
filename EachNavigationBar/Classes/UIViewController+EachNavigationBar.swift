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
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var each_navigationBar: EachNavigationBar {
        return _navigationBar
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var each_navigationItem: UINavigationItem {
        return _navigationItem
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
        
        bindNavigationBar()
        
        if let tableViewController = self as? UITableViewController {
            tableViewController.addObserverForContentOffset()
        }
    }
    
    @objc private func each_viewWillAppear(_ animated: Bool) {
        each_viewWillAppear(animated)
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        updateNavigationBarWhenViewWillAppear()
        bringNavigationBarToFront()
    }
    
    @objc private func each_setNeedsStatusBarAppearanceUpdate() {
        each_setNeedsStatusBarAppearanceUpdate()
        
        adjustsNavigationBarPosition()
    }
}

// MARK: - Setup each navigation bar
extension UIViewController {
    
    var _navigationBar: EachNavigationBar {
        if let bar = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationBar)
            as? EachNavigationBar {
            return bar
        }
        let bar = EachNavigationBar(viewController: self)
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBar, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(
            self,
            &AssociatedKeys.navigationItem)
            as? UINavigationItem {
            return item
        }
        let item = UINavigationItem()
        objc_setAssociatedObject(self, &AssociatedKeys.navigationItem, item, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
    
    private func bindNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.sendNavigationBarToBack()
        setupNavigationBarStyle()
        setupBackBarButtonItem()
        view.addSubview(_navigationBar)
    }
    
    private func bringNavigationBarToFront() {
        view.bringSubviewToFront(_navigationBar)
    }
    
    private func setupNavigationBarStyle() {
        guard let configuration = navigationController?.navigation.configuration else { return }
        _navigationBar.isHidden = configuration.isHidden
        _navigationBar.alpha = configuration.alpha
        _navigationBar.barTintColor = configuration.barTintColor
        _navigationBar.shadowImage = configuration.shadowImage
        _navigationBar.isShadowHidden = configuration.isShadowHidden
        _navigationBar.titleTextAttributes = configuration.titleTextAttributes
        _navigationBar.setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        _navigationBar.isTranslucent = configuration.isTranslucent
        _navigationBar.barStyle = configuration.barStyle
        _navigationBar.statusBarStyle = configuration.statusBarStyle
        _navigationBar.extraHeight = configuration.extraHeight
        if #available(iOS 11.0, *) {
            _navigationBar.prefersLargeTitles = configuration.prefersLargeTitles
            _navigationBar.largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
    
    private func updateNavigationBarWhenViewWillAppear() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barStyle = _navigationBar._barStyle
        navigationBar.isHidden = _navigationBar.isHidden
        if #available(iOS 11.0, *) {
            adjustsSafeAreaInsetsAfterIOS11()
            navigationBar.prefersLargeTitles = _navigationBar.prefersLargeTitles
            navigationBar.largeTitleTextAttributes = _navigationBar.largeTitleTextAttributes
        }
    }
    
    private func setupBackBarButtonItem() {
        guard let navigationController = navigationController,
            navigationController.viewControllers.count > 1,
            let image = navigationController.navigation.configuration.backImage else { return }
        _navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(each_backBarButtonAction))
    }
    
    @objc private func each_backBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    
    private func adjustsNavigationBarPosition() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        _navigationBar.frame = navigationBar.frame
        _navigationBar.frame.size.height += _navigationBar.additionalHeight
        _navigationBar.setNeedsLayout()
    }
    
    func adjustsSafeAreaInsetsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        additionalSafeAreaInsets.top = _navigationBar.isHidden ? -view.safeAreaInsets.top : 0
    }
}
