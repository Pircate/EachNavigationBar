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
        
        public var isEnabled = false {
            didSet { UIViewController.methodSwizzling }
        }
        
        public var isHidden = false
        
        public var alpha: CGFloat = 1
        
        public var barTintColor: UIColor?
        
        public var tintColor: UIColor?
        
        public var shadow: Shadow?
        
        public var shadowImage: UIImage?
        
        // Hides shadow image.
        public var isShadowHidden: Bool = false
        
        public var titleTextAttributes: [NSAttributedString.Key : Any]?
        
        public var isTranslucent: Bool = true
        
        public var barStyle: UIBarStyle = .default
        
        public var statusBarStyle: UIStatusBarStyle = .default
        
        /// Additional height for the navigation bar.
        public var additionalHeight: CGFloat = 0
        
        public var backItem: BackItem?
        
        var background: Background = .init()
        
        private var _layoutPaddings: UIEdgeInsets = .barLayoutPaddings
        
        private var _prefersLargeTitles: Bool = false
        
        private var _largeTitle: LargeTitle = .init()
    }
}

public extension UINavigationController.Configuration {
    
    /// Padding of navigation bar content view.
    var layoutPaddings: UIEdgeInsets {
        get { _layoutPaddings }
        set { _layoutPaddings = newValue }
    }
    
    var prefersLargeTitles: Bool {
        get { _prefersLargeTitles }
        set { _prefersLargeTitles = newValue }
    }
    
    var largeTitle: LargeTitle {
        get { _largeTitle }
        set { _largeTitle = newValue }
    }
    
    func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition = .any,
        barMetrics: UIBarMetrics = .default
    ) {
        self.background.image = backgroundImage
        self.background.barPosition = barPosition
        self.background.barMetrics = barMetrics
    }
}

extension UINavigationController.Configuration {
    
    public struct BackItem {
        public let style: Style
        public let tintColor: UIColor?
        
        public enum Style {
            case title(String?)
            case image(UIImage?)
        }
        
        public init(style: Style, tintColor: UIColor? = nil) {
            self.style = style
            self.tintColor = tintColor
        }
    }
    
    public struct LargeTitle {
        public var textAttributes: [NSAttributedString.Key: Any]?
        public var displayMode: UINavigationItem.LargeTitleDisplayMode = .automatic
    }
    
    struct Background {
        var image: UIImage?
        var barMetrics: UIBarMetrics = .default
        var barPosition: UIBarPosition = .any
    }
}
