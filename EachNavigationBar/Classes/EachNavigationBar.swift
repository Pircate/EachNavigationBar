//
//  EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/28.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

open class EachNavigationBar: UINavigationBar {
    
    /// Default is false. If set true, navigation bar will not restore
    /// when the UINavigationController call viewWillLayoutSubviews
    @objc open var isUnrestoredWhenViewWillLayoutSubviews = false
    
    @objc open var extraHeight: CGFloat = 0 {
        didSet {
            frame.size.height = barHeight + additionalHeight
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    /// Hides shadow image
    @objc open var isShadowHidden: Bool = false {
        didSet {
            guard let background = subviews.first else { return }
            background.clipsToBounds = isShadowHidden
        }
    }
    
    @objc open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            superNavigationBar?.barStyle = _barStyle
        }
    }
    
    @objc open var backBarButtonItem: BackBarButtonItem = .none {
        didSet {
            backBarButtonItem.navigationController = viewController?.navigationController
            
            let item = backBarButtonItem.makeBarButtonItem()
            viewController?._navigationItem.leftBarButtonItem = item
        }
    }

    var shadow: Shadow = .init() {
        didSet {
            layer.shadowColor = shadow.color
            layer.shadowOpacity = shadow.opacity
            layer.shadowOffset = shadow.offset
            layer.shadowRadius = shadow.radius
            layer.shadowPath = shadow.path
        }
    }
    
    @available(iOS 11.0, *)
    @objc public lazy var layoutPaddings: UIEdgeInsets = {
        Const.NavigationBar.layoutPaddings
    }()
    
    private var _contentView: UIView?
    
    private var _alpha: CGFloat = 1
    
    private weak var viewController: UIViewController?
    
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        _layoutSubviews()
    }
}

extension EachNavigationBar {
    
    open override var isHidden: Bool {
        didSet {
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    open override var alpha: CGFloat {
        get {
            return super.alpha
        }
        set {
            _alpha = newValue
            
            layer.shadowOpacity = newValue < 1 ? 0 : shadow.opacity
            
            if let background = subviews.first {
                background.alpha = newValue
            }
        }
    }
    
    /// map to barTintColor
    open override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            barTintColor = newValue
        }
    }
}

extension EachNavigationBar {
    
    @available(iOS 11.0, *)
    open override var prefersLargeTitles: Bool {
        get {
            return super.prefersLargeTitles
        }
        set {
            super.prefersLargeTitles = newValue
            
            updateLargeTitleDisplayMode(for: newValue)
        }
    }
    
    @available(iOS 11.0, *)
    open override var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get {
            return super.largeTitleTextAttributes
        }
        set {
            super.largeTitleTextAttributes = newValue
            
            superNavigationBar?.largeTitleTextAttributes = newValue
        }
    }
}

extension EachNavigationBar {
    
    var _barStyle: UIBarStyle {
        return statusBarStyle == .default ? .default : .black
    }
    
    var additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if prefersLargeTitles { return 0 }
        }
        return extraHeight
    }
    
    private var superNavigationBar: UINavigationBar? {
        return viewController?.navigationController?.navigationBar
    }
    
    private var barHeight: CGFloat {
        if let bar = superNavigationBar {
            return bar.frame.height
        } else {
            return Const.NavigationBar.height
        }
    }
}

extension EachNavigationBar {
    
    @available(iOS 11.0, *)
    private var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        _contentView = subviews
            .filter {
                String(describing: $0.classForCoder) == "_UINavigationBarContentView"
            }.first
        return _contentView
    }
    
    private func _layoutSubviews() {
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.clipsToBounds = isShadowHidden
        background.frame = CGRect(
            x: 0,
            y: -Const.StatusBar.maxY,
            width: bounds.width,
            height: bounds.height + Const.StatusBar.maxY)
        
        adjustsContentViewFrameAfterIOS11()
    }
    
    private func adjustsContentViewFrameAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        contentView?.frame.origin.y = additionalHeight
        contentView?.layoutMargins = layoutPaddings
    }
    
    @available(iOS 11.0, *)
    private func updateLargeTitleDisplayMode(for prefersLargeTitles: Bool) {
        superNavigationBar?.prefersLargeTitles = prefersLargeTitles
        viewController?.navigationItem.largeTitleDisplayMode = prefersLargeTitles ? .always : .never
    }
}
