//
//  UIViewController+NavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIViewController {
    
    public static let setupNavigationBar: Void = {
        if let viewDidLoad = class_getInstanceMethod(UIViewController.self, #selector(viewDidLoad)),
            let each_viewDidLoad = class_getInstanceMethod(UIViewController.self, #selector(each_viewDidLoad)),
            let viewWillAppear = class_getInstanceMethod(UIViewController.self, #selector(viewWillAppear(_:))),
            let each_viewWillAppear = class_getInstanceMethod(UIViewController.self, #selector(each_viewWillAppear(_:))) {
            method_exchangeImplementations(viewDidLoad, each_viewDidLoad)
            method_exchangeImplementations(viewWillAppear, each_viewWillAppear)
        }
    }()
    
    var _navigationBar: EachNavigationBar {
        if let bar = objc_getAssociatedObject(self, &AssociatedKeys.navigationBar) as? EachNavigationBar {
            return bar
        }
        let bar = EachNavigationBar(navigationItem: _navigationItem)
        objc_setAssociatedObject(self, &AssociatedKeys.navigationBar, bar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return bar
    }
    
    var _navigationItem: UINavigationItem {
        if let item = objc_getAssociatedObject(self, &AssociatedKeys.navigationItem) as? UINavigationItem {
            return item
        }
        let item = UINavigationItem()
        objc_setAssociatedObject(self, &AssociatedKeys.navigationItem, item, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
    
    @objc private func each_viewDidLoad() {
        each_viewDidLoad()
        bindNavigationBar()
    }
    
    @objc private func each_viewWillAppear(_ animated: Bool) {
        each_viewWillAppear(animated)
        bringNavigationBarToFront()
    }
}

extension UIViewController {
    
    public func adjustsNavigationBarPosition() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        _navigationBar.frame = navigationBar.frame
        _navigationBar.frame.size.height += _navigationBar.extraHeight
        _navigationBar.setNeedsLayout()
    }
    
    private func bindNavigationBar() {
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        navigationController.navigationBar.isHidden = true
        configureNavigationBarStyle()
        setupBackBarButtonItem()
        view.addSubview(_navigationBar)
    }
    
    private func bringNavigationBarToFront() {
        guard let navigationController = navigationController,
            navigationController.navigation.configuration.isEnabled else { return }
        view.bringSubview(toFront: _navigationBar)
    }
    
    private func configureNavigationBarStyle() {
        guard let configuration = navigationController?.navigation.configuration else { return }
        _navigationBar.barTintColor = configuration.barTintColor
        _navigationBar.shadowImage = configuration.shadowImage
        _navigationBar.titleTextAttributes = configuration.titleTextAttributes
        _navigationBar.setBackgroundImage(configuration.backgroundImage, for: configuration.position, barMetrics: configuration.metrics)
        _navigationBar.isTranslucent = configuration.isTranslucent
        _navigationBar.barStyle = configuration.barStyle
        _navigationBar.extraHeight = configuration.extraHeight
    }
    
    private func setupBackBarButtonItem() {
        guard let navigationController = navigationController,
            navigationController.viewControllers.count > 1,
            let image = navigationController.navigation.configuration.backImage else { return }
        _navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(backAction))
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let bar = topViewController?.navigation.bar else { return }
        
        if #available(iOS 11.0, *) {
            bar.prefersLargeTitles = navigationBar.prefersLargeTitles
            bar.largeTitleTextAttributes = navigationBar.largeTitleTextAttributes
        }
        
        if bar.isUnrestoredWhenViewWillLayoutSubviews {
            bar.frame.size = navigationBar.frame.size
        } else {
            bar.frame = navigationBar.frame
            if #available(iOS 11.0, *) {
                if bar.prefersLargeTitles {
                    bar.frame.origin.y = UIApplication.shared.statusBarFrame.maxY
                }
            }
        }
        bar.frame.size.height = navigationBar.frame.height + bar.extraHeight
    }
}
