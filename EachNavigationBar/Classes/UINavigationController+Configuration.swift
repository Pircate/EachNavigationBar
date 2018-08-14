//
//  UINavigationController+Configuration.swift
//  EachNavigationBar
//
//  Created by Pircate on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit
import ObjectiveC

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
        
        /// Extra height for the navigation bar.
        public var extraHeight: CGFloat = 0
        
        /// Image for leftBarButtonItem(not backBarButtonItem). If you don't set, there will be no back button by default.
        public var backImage: UIImage?
    }
    
    var _configuration: Configuration {
        if let configuration = objc_getAssociatedObject(self, &AssociatedKeys.configuration) as? Configuration {
            return configuration
        }
        let configuration = Configuration()
        objc_setAssociatedObject(self, &AssociatedKeys.configuration, configuration, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return configuration
    }
}
