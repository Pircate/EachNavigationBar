//
//  EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/28.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

open class EachNavigationBar: UINavigationBar {
    
    /// automatically adjusts position when view layout
    open var automaticallyAdjustsPosition: Bool = true
    
    /// Additional height for the navigation bar.
    open var additionalHeight: CGFloat = 0 {
        didSet {
            frame.size.height = barHeight + _additionalHeight
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    /// Hides shadow image
    open var isShadowHidden: Bool = false {
        didSet {
            guard let background = subviews.first else { return }
            background.clipsToBounds = isShadowHidden
        }
    }
    
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            superNavigationBar?.barStyle = _barStyle
        }
    }
    
    /// Bar button item to use for the back button in the child navigation item.
    open var backBarButtonItem: BackBarButtonItem? {
        didSet {
            backBarButtonItem?.navigationController = viewController?.navigationController
            
            viewController?._navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }

    @available(iOS 11.0, *)
    /// Padding of navigation bar content view.
    public lazy var layoutPaddings: UIEdgeInsets = {
        Const.NavigationBar.layoutPaddings
    }()
    
    open var additionalView: UIView? {
        didSet {
            guard let additionalView = additionalView else {
                oldValue?.removeFromSuperview()
                return
            }
            
            setupAdditionalView(additionalView)
        }
    }
    
    open var shadow: Shadow = .none {
        didSet { layer.set(shadow) }
    }
    
    private var _contentView: UIView?
    
    var _alpha: CGFloat = 1
    
    weak var viewController: UIViewController?
    
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
    
    var _barStyle: UIBarStyle {
        return statusBarStyle == .default ? .default : .black
    }
    
    var _additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if prefersLargeTitles { return 0 }
        }
        return additionalHeight
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
    
    private var superNavigationBar: UINavigationBar? {
        return viewController?.navigationController?.navigationBar
    }
    
    @available(iOS 11.0, *)
    private var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        let className: String
        if #available(iOS 13.0, *) {
            className = "UINavigationBarContentView"
        } else {
            className = "_UINavigationBarContentView"
        }
        _contentView = subviews.filter { String(describing: $0.classForCoder) == className }.first
        
        return _contentView
    }
    
    private func setupAdditionalView(_ additionalView: UIView) {
        addSubview(additionalView)
        additionalView.translatesAutoresizingMaskIntoConstraints = false
        additionalView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        additionalView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        additionalView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        additionalView.heightAnchor.constraint(
            equalToConstant: additionalView.frame.height).isActive = true
    }
}

extension EachNavigationBar {
    
    func adjustsLayout() {
        guard let navigationBar = viewController?.navigationController?.navigationBar else { return }
        
        if automaticallyAdjustsPosition {
            frame = navigationBar.frame
            if #available(iOS 11.0, *) {
                if prefersLargeTitles {
                    frame.origin.y = Const.StatusBar.maxY
                }
            }
        } else {
            frame.size = navigationBar.frame.size
        }
        
        frame.size.height = navigationBar.frame.height + _additionalHeight
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
        
        adjustsLayoutMarginsAfterIOS11()
    }
    
    private func adjustsLayoutMarginsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        layoutMargins = Const.NavigationBar.layoutMargins
        contentView?.frame.origin.y = prefersLargeTitles ? 0 : additionalHeight
        contentView?.layoutMargins = layoutPaddings
    }
}
