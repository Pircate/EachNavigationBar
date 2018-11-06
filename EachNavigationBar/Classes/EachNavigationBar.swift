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
            frame.size.height = 44.0 + additionalHeight
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
            viewController?.navigationController?.navigationBar.barStyle = _barStyle
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
            frame.size.height =  44.0 + additionalHeight
        }
    }
    
    var _barStyle: UIBarStyle {
        return statusBarStyle == .default ? .default : .black
    }
    
    private lazy var _contentView: UIView? = {
        subviews.filter {
            String(describing: $0.classForCoder) == "_UINavigationBarContentView"
        }.first
    }()
    
    private var _alpha: CGFloat = 1
    
    private var scrollViewsForAdjustsContentInset: Set<UIScrollView> = []
    
    private weak var viewController: UIViewController?
    
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollViewsForAdjustsContentInset.forEach {
            adjustsScrollViewContentInset($0)
        }
        
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.clipsToBounds = isShadowHidden
        background.frame = CGRect(
            x: 0,
            y: -UIApplication.shared.statusBarFrame.maxY,
            width: bounds.width,
            height: bounds.height + UIApplication.shared.statusBarFrame.maxY)
        
        if #available(iOS 11.0, *) {
            _contentView?.frame.origin.y = extraHeight
        }
    }
}

extension EachNavigationBar {
    
    var additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return extraHeight + largeTitleHeight
        } else {
            return extraHeight
        }
    }
    
    @available(iOS 11.0, *)
    private var largeTitleHeight: CGFloat {
        guard prefersLargeTitles else { return 0 }
        guard let largeTitleTextAttributes = largeTitleTextAttributes,
            let font = largeTitleTextAttributes[.font] as? UIFont else {
                return 49
        }
        let size = font.pointSize * 1.2
        return size > 49 ? size : 49
    }
}

extension EachNavigationBar {
    
    func appendScrollView(forAdjustsContentInset scrollView: UIScrollView) {
        scrollViewsForAdjustsContentInset.insert(scrollView)
    }
    
    private func adjustsScrollViewContentInset(_ scrollView: UIScrollView) {
        guard let viewController = viewController else { return }
        let bar = viewController._navigationBar
        let barMaxY = bar.isHidden ? bar.frame.minY : bar.frame.maxY
        let scrollViewY = viewController.view.convert(scrollView.frame, to: viewController.view).minY
        guard scrollViewY < barMaxY else { return }
        let contentInsetTop: CGFloat
        if #available(iOS 11.0, *) {
            if scrollView.contentInsetAdjustmentBehavior == .never {
                contentInsetTop = barMaxY - scrollViewY
            } else {
                let inset = max(scrollViewY, viewController.view.safeAreaInsets.top)
                contentInsetTop = barMaxY - inset
            }
        } else {
            contentInsetTop = barMaxY - scrollViewY
        }
        scrollView.contentInset.top = contentInsetTop
        scrollView.scrollIndicatorInsets.top = contentInsetTop
    }
}
