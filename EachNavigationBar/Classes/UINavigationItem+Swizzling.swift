// 
//  UINavigationItem+Swizzling.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2019/2/3
//  Copyright © 2019年 Pircate. All rights reserved.
//

private func <=>(left: Selector, right: Selector) {
    if let originalMethod = class_getInstanceMethod(UINavigationItem.self, left),
        let swizzledMethod = class_getInstanceMethod(UINavigationItem.self, right) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UINavigationItem {
    
    static let methodSwizzling: Void = {
        #selector(setLeftBarButton(_:animated:)) <=> #selector(navigation_setLeftBarButton(_:animated:))
        #selector(setRightBarButton(_:animated:)) <=> #selector(navigation_setRightBarButton(_:animated:))
    }()
    
    @objc private func navigation_setLeftBarButton(_ item: UIBarButtonItem?, animated: Bool) {
        setLeftBarButton(item, animated: animated, fixedSpace: -8)
    }
    
    @objc private func navigation_setRightBarButton(_ item: UIBarButtonItem?, animated: Bool) {
        setRightBarButton(item, animated: animated, fixedSpace: -8)
    }
    
    @objc public func setLeftBarButton(
        _ item: UIBarButtonItem?,
        animated: Bool,
        fixedSpace width: CGFloat) {
        if #available(iOS 11.0, *) {
            item?.customView?.frame.size.height = Const.NavigationBar.height
            navigation_setLeftBarButton(item, animated: animated)
            return
        }
        
        guard let item = item else {
            setLeftBarButtonItems([], animated: animated)
            return
        }
        
        if let _ = item.customView {
            setLeftBarButtonItems([UIBarButtonItem.fixedSpace(width), item], animated: animated)
        } else {
            setLeftBarButtonItems([item], animated: animated)
        }
    }
    
    @objc public func setRightBarButton(
        _ item: UIBarButtonItem?,
        animated: Bool,
        fixedSpace width: CGFloat) {
        if #available(iOS 11.0, *) {
            item?.customView?.frame.size.height = Const.NavigationBar.height
            navigation_setRightBarButton(item, animated: animated)
            return
        }
        
        guard let item = item else {
            setRightBarButtonItems([], animated: animated)
            return
        }
        
        if let _ = item.customView {
            setRightBarButtonItems([UIBarButtonItem.fixedSpace(width), item], animated: animated)
        } else {
            setRightBarButtonItems([item], animated: animated)
        }
    }
}

private extension UIBarButtonItem {
    
    static func fixedSpace(_ width: CGFloat) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = width
        return item
    }
}
