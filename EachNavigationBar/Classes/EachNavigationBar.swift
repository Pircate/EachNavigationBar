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
            adjustsLayout()
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

    @available(iOS 11.0, *)
    @objc public lazy var layoutPaddings: UIEdgeInsets = {
        Const.NavigationBar.layoutPaddings
    }()
    
    @objc public var additionalView: UIView? {
        didSet {
            guard let additionalView = additionalView else {
                oldValue?.removeFromSuperview()
                return
            }
            
            setupAdditionalView(additionalView)
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
    
    var additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if prefersLargeTitles { return 0 }
        }
        return extraHeight
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
        
        _contentView = subviews
            .filter {
                String(describing: $0.classForCoder) == "_UINavigationBarContentView"
            }.first
        
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
        frame.size.height = barHeight + additionalHeight
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
        contentView?.frame.origin.y = prefersLargeTitles ? 0 : extraHeight
        contentView?.layoutMargins = layoutPaddings
    }
}
