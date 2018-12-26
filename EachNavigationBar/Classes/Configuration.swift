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
    
    public var backBarButtonItem: BackBarButtonItem = .init(style: .none)
    
    @objc public var prefersLargeTitles: Bool = false
    
    @objc public var largeTitleTextAttributes: [NSAttributedString.Key: Any]?
    
    var backgroundImage: UIImage?
    
    var barMetrics: UIBarMetrics = .default
    
    var barPosition: UIBarPosition = .any
}

extension Configuration {
    
    @objc public func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition,
        barMetrics: UIBarMetrics) {
        self.backgroundImage = backgroundImage
        self.barPosition = barPosition
        self.barMetrics = barMetrics
    }
}
