//
//  UINavigationController+Configuration.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public final class Configuration {
        
        public var isEnabled = false
        
        public var isHidden = false
        
        public var alpha: CGFloat = 1
        
        public var barTintColor: UIColor?
        
        public var tintColor: UIColor?
        
        public var shadowImage: UIImage?
        
        // Hides shadow image.
        public var isShadowHidden: Bool = false
        
        public var titleTextAttributes: [NSAttributedString.Key : Any]?
        
        public var isTranslucent: Bool = true
        
        public var barStyle: UIBarStyle = .default
        
        public var statusBarStyle: UIStatusBarStyle = .default
        
        /// Additional height for the navigation bar.
        public var additionalHeight: CGFloat = 0
        
        public var shadow: Shadow?
        
        public var backItem: BackItem?
        
        var _layoutPaddings: UIEdgeInsets = Const.NavigationBar.layoutPaddings
        
        var _largeTitleTextAttributes: [NSAttributedString.Key: Any]?
        
        var backgroundImage: UIImage?
        
        var barMetrics: UIBarMetrics = .default
        
        var barPosition: UIBarPosition = .any
    }
}

extension UINavigationController.Configuration {
    
    public struct BackItem {
        public let style: BackBarButtonItem.ItemStyle
        public let tintColor: UIColor?
        
        public init(style: BackBarButtonItem.ItemStyle, tintColor: UIColor? = nil) {
            self.style = style
            self.tintColor = tintColor
        }
    }
}

public extension UINavigationController.Configuration {
    
    @available(iOS 11.0, *)
    /// Padding of navigation bar content view.
    var layoutPaddings: UIEdgeInsets {
        get { _layoutPaddings }
        set { _layoutPaddings = newValue }
    }
    
    @available(iOS 11.0, *)
    var largeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        get { _largeTitleTextAttributes }
        set { _largeTitleTextAttributes = newValue }
    }
    
    func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition = .any,
        barMetrics: UIBarMetrics = .default
    ) {
        self.backgroundImage = backgroundImage
        self.barPosition = barPosition
        self.barMetrics = barMetrics
    }
}
