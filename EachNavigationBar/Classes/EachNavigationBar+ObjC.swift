// 
//  EachNavigationBar+ObjC.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UINavigationController {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var navigation_configuration: Configuration {
        return _configuration
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @available(iOS 11.0, *)
    @objc public func navigation_prefersLargeTitles() {
        navigationBar.prefersLargeTitles = true
    }
}

extension UIViewController {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public static func navigation_methodSwizzling() {
        methodSwizzling
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var navigation_bar: EachNavigationBar {
        assert(!(self is UINavigationController), "UINavigationController can't use this property.")
        return _navigationBar
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var navigation_item: UINavigationItem {
        assert(!(self is UINavigationController), "UINavigationController can't use this property.")
        return _navigationItem
    }
}

public extension BackBarButtonItem {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(title: String?) {
        self.init(style: .title(title), tintColor: nil)
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(title: String?, tintColor: UIColor?) {
        self.init(style: .title(title), tintColor: tintColor)
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(image: UIImage?) {
        self.init(style: .image(image), tintColor: nil)
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(image: UIImage?, tintColor: UIColor?) {
        self.init(style: .image(image), tintColor: tintColor)
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(customView: UIButton) {
        self.init(style: .custom(customView), tintColor: nil)
    }
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc convenience init(customView: UIButton, tintColor: UIColor?) {
        self.init(style: .custom(customView), tintColor: tintColor)
    }
}

extension UINavigationItem {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public static func navigation_methodSwizzling() {
        methodSwizzling
    }
}
