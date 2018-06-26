//
//  UINavigationController+Configuration.swift
//  EachNavigationBar
//
//  Created by Pircate on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import ObjectiveC

private var kUINavigationControllerConfigurationKey = "UI_NAVIGATION_CONTROLLER_CONFIGURATION_KEY"

extension UINavigationController {
    
    public class Configuration {
        public var isEnabled = false
        public var barTintColor: UIColor?
        public var backgroundImage: UIImage?
        public var metrics: UIBarMetrics = .default
        public var position: UIBarPosition = .any
        public var shadowImage: UIImage?
        public var titleTextAttributes: [NSAttributedStringKey : Any]?
        public var isTranslucent: Bool = true
        public var barStyle: UIBarStyle = .default
        public var extraHeight: CGFloat = 0
    }
    
    var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(self, &kUINavigationControllerConfigurationKey) as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(self, &kUINavigationControllerConfigurationKey, configuration, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}
