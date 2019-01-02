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
}

extension UIViewController {
    
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

extension Configuration {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public func setBackBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        guard let backBarButtonItem = barButtonItem.makeBackBarButtonItem() else { return }
        self.backBarButtonItem = backBarButtonItem
    }
}

private extension UIBarButtonItem {
    
    func makeBackBarButtonItem() -> BackBarButtonItem? {
        if let title = self.title {
            return BackBarButtonItem(style: .title(title), tintColor: tintColor)
        } else if let image = self.image {
            return BackBarButtonItem(style: .image(image), tintColor: tintColor)
        } else if let customView = self.customView as? UIButton {
            return BackBarButtonItem(style: .custom(customView), tintColor: tintColor)
        }
        return nil
    }
}
