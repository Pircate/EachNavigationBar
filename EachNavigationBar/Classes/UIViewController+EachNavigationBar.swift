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

// MARK: - Setup navigation bar
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
        let item = UINavigationItem()
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.navigationItem,
            item,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return item
    }
    
    func setupNavigationBarWhenViewDidLoad() {
        guard let navigationController = navigationController else { return }
        navigationController.sendNavigationBarToBack()
        _navigationBar.setup(with: navigationController._configuration)
        setupBackBarButtonItem()
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
    
    private func setupBackBarButtonItem() {
        guard let navigationController = navigationController,
            navigationController.viewControllers.count > 1 else { return }
        
        let backBarButtonItem = navigationController._configuration.backBarButtonItem
        switch backBarButtonItem.style {
        case .none:
            break
        case .title(let title):
            _navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(each_backBarButtonAction))
            _navigationItem.leftBarButtonItem?.tintColor = backBarButtonItem.tintColor
        case .image(let image):
            _navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(each_backBarButtonAction))
            _navigationItem.leftBarButtonItem?.tintColor = backBarButtonItem.tintColor
        case .custom(let customView):
            customView.addTarget(self, action: #selector(each_backBarButtonAction), for: .touchUpInside)
            customView.tintColor = backBarButtonItem.tintColor
            _navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
        }
    }
    
    @objc private func each_backBarButtonAction() {
        navigationController?.popViewController(animated: true)
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
