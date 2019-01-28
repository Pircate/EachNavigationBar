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
    
    open var backBarButtonItem: BackBarButtonItem = .init(style: .none) {
        didSet {
            let item = backBarButtonItem.makeBarButtonItem(self, action: #selector(backBarButtonItemAction))
            if #available(iOS 11.0, *) {
                viewController?._navigationItem.leftBarButtonItem = item
            } else {
                if case .custom = backBarButtonItem.style {
                    let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                    space.width = -Const.NavigationBar.padding.left
                    viewController?._navigationItem.leftBarButtonItems = [space, item].compactMap { $0 }
                } else {
                    viewController?._navigationItem.leftBarButtonItems = [item].compactMap { $0 }
                }
            }
        }
    }
    
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
    
    @available(iOS 11.0, *)
    private lazy var _contentView: UIView? = {
        subviews.filter { String(describing: $0.classForCoder) == "_UINavigationBarContentView" }.first
    }()
    
    private var _layoutPadding: UIEdgeInsets = Const.NavigationBar.padding
    
    private var _alpha: CGFloat = 1
    
    private weak var viewController: UIViewController?
    
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateSubviews()
    }
    
    @objc private func backBarButtonItemAction() {
        backBarButtonItem.willBack()
        viewController?.navigationController?.popViewController(animated: true)
        backBarButtonItem.didBack()
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
    open var layoutPadding: UIEdgeInsets {
        get {
            return _layoutPadding
        }
        set {
            _layoutPadding = newValue
        }
    }
}

extension EachNavigationBar {
    
    private func updateSubviews() {
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
        _contentView?.frame.origin.y = additionalHeight
        _contentView?.layoutMargins = _layoutPadding
    }
    
    @available(iOS 11.0, *)
    private func updateLargeTitleDisplayMode(for prefersLargeTitles: Bool) {
        superNavigationBar?.prefersLargeTitles = prefersLargeTitles
        viewController?.navigationItem.largeTitleDisplayMode = prefersLargeTitles ? .always : .never
    }
}
