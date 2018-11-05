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
    
    @available(swift, deprecated: 4.2, message: "Please use navigation.swizzle() instead.")
    public static let setupNavigationBar: Void = {
        selector_exchangeImplementations(#selector(viewDidLoad), #selector(each_viewDidLoad))
        selector_exchangeImplementations(
            #selector(viewWillAppear(_:)),
            #selector(each_viewWillAppear(_:)))
        selector_exchangeImplementations(
            #selector(setNeedsStatusBarAppearanceUpdate),
            #selector(each_setNeedsStatusBarAppearanceUpdate))
    }()
    
    @available(swift, obsoleted: 4.2, message: "Please use navigation.bar instead.")
    @objc public var each_navigationBar: EachNavigationBar {
        return _navigationBar
    }
    
    @available(swift, obsoleted: 4.2, message: "Please use navigation.item instead.")
    @objc public var each_navigationItem: UINavigationItem {
        return _navigationItem
    }
    
    @available(swift, obsoleted: 4.2, message: "Please use setupNavigationBar instead.")
    @objc public static func swizzle_setupNavigationBar() {
        setupNavigationBar
    }
    
    @objc public func adjustsNavigationBarPosition() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        _navigationBar.frame = navigationBar.frame
        _navigationBar.frame.size.height += _navigationBar.additionalHeight
        _navigationBar.setNeedsLayout()
    }
    
    @objc public func adjustsScrollViewContentInset(_ scrollView: UIScrollView) {
        _navigationBar.appendScrollViewForAdjustsContentInset(scrollView)
    }
}

// MARK: - Swizzle
extension UIViewController {
    
    private var asTableViewController: UITableViewController? {
        return self as? UITableViewController
    }
    
    private static func selector_exchangeImplementations(_ sel1: Selector, _ sel2: Selector) {
        if let originalMethod = class_getInstanceMethod(UIViewController.self, sel1),
            let swizzledMethod = class_getInstanceMethod(UIViewController.self, sel2) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @objc private func each_viewDidLoad() {
        each_viewDidLoad()
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        bindNavigationBar()
        asTableViewController?.addObserverForContentOffset()
    }
    
    @objc private func each_viewWillAppear(_ animated: Bool) {
        each_viewWillAppear(animated)
        
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        
        navigationController.navigationBar.barStyle = _navigationBar._barStyle
        bringNavigationBarToFront()
        asTableViewController?.adjustsTableViewContentInset()
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
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.isHidden = true
        setupNavigationBarStyle()
        setupBackBarButtonItem()
        view.addSubview(_navigationBar)
    }
    
    private func bringNavigationBarToFront() {
        #if swift(>=4.2)
        view.bringSubviewToFront(_navigationBar)
        #else
        view.bringSubview(toFront: each_navigationBar)
        #endif
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
    
    var statusBarMaxY: CGFloat {
        return UIApplication.shared.statusBarFrame.maxY
    }
}
