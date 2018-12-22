//
//  UIViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension UIViewController {

    func setupNavigationBarWhenViewDidLoad() {
        guard let navigationController = navigationController else { return }
        navigationController.sendNavigationBarToBack()
        
        let configuration = navigationController._configuration
        _navigationBar.setup(with: configuration)
        
        if navigationController.viewControllers.count > 1 {
            configuration.backBarButtonItem.needsDuplicate = true
            _navigationBar.backBarButtonItem = configuration.backBarButtonItem
        }
        
        view.addSubview(_navigationBar)
    }
    
    func updateNavigationBarWhenViewWillAppear() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barStyle = _navigationBar._barStyle
        navigationBar.isHidden = _navigationBar.isHidden
        if #available(iOS 11.0, *) {
            adjustsSafeAreaInsetsAfterIOS11()
            navigationBar.prefersLargeTitles = _navigationBar.prefersLargeTitles
            navigationBar.largeTitleTextAttributes = _navigationBar.largeTitleTextAttributes
        }
        view.bringSubviewToFront(_navigationBar)
    }
}

extension UIViewController {
    
    func adjustsNavigationBarPosition() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        _navigationBar.frame = navigationBar.frame
        _navigationBar.frame.size.height += _navigationBar.additionalHeight
        _navigationBar.setNeedsLayout()
    }
    
    func adjustsSafeAreaInsetsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        additionalSafeAreaInsets.top = _navigationBar.isHidden
            ? -view.safeAreaInsets.top
            : _navigationBar.additionalHeight
    }
}

private extension EachNavigationBar {
    
    func setup(with configuration: Configuration) {
        isHidden = configuration.isHidden
        alpha = configuration.alpha
        barTintColor = configuration.barTintColor
        shadowImage = configuration.shadowImage
        isShadowHidden = configuration.isShadowHidden
        titleTextAttributes = configuration.titleTextAttributes
        setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        isTranslucent = configuration.isTranslucent
        barStyle = configuration.barStyle
        statusBarStyle = configuration.statusBarStyle
        extraHeight = configuration.extraHeight
        if #available(iOS 11.0, *) {
            prefersLargeTitles = configuration.prefersLargeTitles
            largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
}
