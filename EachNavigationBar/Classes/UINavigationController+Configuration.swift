//
//  UINavigationController+Configuration.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import ObjectiveC

public class Configuration: NSObject {
    
    @objc public var isEnabled = false
    
    @objc public var isHidden = false
    
    @objc public var alpha: CGFloat = 1
    
    @objc public var barTintColor: UIColor?
    
    @objc public var shadowImage: UIImage?
    
    @objc public var isShadowHidden: Bool = false
    
    @objc public var titleTextAttributes: [NSAttributedString.Key : Any]?
    
    @objc public var isTranslucent: Bool = true
    
    @objc public var barStyle: UIBarStyle = .default
    
    @objc public var statusBarStyle: UIStatusBarStyle = .default
    
    /// Extra height for the navigation bar.
    @objc public var extraHeight: CGFloat = 0
    
    /// Image for leftBarButtonItem(not backBarButtonItem).
    /// If you don't set, there will be no back button by default.
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var backImage: UIImage?
    
    public var backBarButtonItem: BackBarButtonItem = .init()
    
    @objc public var prefersLargeTitles: Bool = false
    
    @objc public var largeTitleTextAttributes: [NSAttributedString.Key: Any]?
    
    var backgroundImage: UIImage?
    
    var barMetrics: UIBarMetrics = .default
    
    var barPosition: UIBarPosition = .any
    
    @objc public func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition,
        barMetrics: UIBarMetrics) {
        self.backgroundImage = backgroundImage
        self.barPosition = barPosition
        self.barMetrics = barMetrics
    }
}

extension UINavigationController {
    
    @available(swift, obsoleted: 4.2, message: "Only for Objective-C call.")
    @objc public var global_configuration: Configuration {
        return _configuration
    }
    
    var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(
            self,
            &AssociatedKeys.configuration)
            as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(
            self,
            &AssociatedKeys.configuration,
            configuration,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}
