// 
//  EachNavigationBar+Override.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2019/2/15
//  Copyright © 2019年 Pircate. All rights reserved.
//

extension EachNavigationBar {
    
    open override var isHidden: Bool {
        didSet { viewController?.adjustsSafeAreaInsetsAfterIOS11() }
    }
    
    open override var alpha: CGFloat {
        get { return super.alpha }
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
        get { return super.backgroundColor }
        set { barTintColor = newValue }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        return additionalView?.frame.contains(point) ?? false
    }
}

extension EachNavigationBar {
    
    @available(iOS 11.0, *)
    open override var prefersLargeTitles: Bool {
        get { return super.prefersLargeTitles }
        set {
            super.prefersLargeTitles = newValue
            
            viewController?.navigationItem.largeTitleDisplayMode = newValue ? .always : .never
        }
    }
    
    @available(iOS 11.0, *)
    open override var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return super.largeTitleTextAttributes }
        set {
            super.largeTitleTextAttributes = newValue
            
            viewController?.navigationItem.title = viewController?._navigationItem.title
            let superNavigationBar = viewController?.navigationController?.navigationBar
            superNavigationBar?.largeTitleTextAttributes = newValue
        }
    }
}
