//
//  EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/28.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

open class EachNavigationBar: UINavigationBar {

    private var _alpha: CGFloat = 1
    
    /// Default is false. If set true, navigation bar will not restore when the UINavigationController call viewWillLayoutSubviews
    @objc open var isUnrestoredWhenViewWillLayoutSubviews = false
    
    @objc open var extraHeight: CGFloat = 0 {
        didSet {
            frame.size.height = 44.0 + additionalHeight
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
    
    private lazy var _contentView: UIView? = {
        subviews.filter {
            String(describing: $0.classForCoder) == "_UINavigationBarContentView"
        }.first
    }()
    
    public convenience init(navigationItem: UINavigationItem) {
        self.init()
        setItems([navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.frame = CGRect(
            x: 0,
            y: -UIApplication.shared.statusBarFrame.maxY,
            width: bounds.width,
            height: bounds.height + UIApplication.shared.statusBarFrame.maxY)
        
        _contentView?.frame.origin.y = extraHeight
    }
}

extension EachNavigationBar {
    
    @available(iOS 11.0, *)
    var largeTitleHeight: CGFloat {
        guard prefersLargeTitles else { return 0 }
        guard let largeTitleTextAttributes = largeTitleTextAttributes,
            let font = largeTitleTextAttributes[.font] as? UIFont else {
                return 49
        }
        let size = font.pointSize * 1.2
        return size > 49 ? size : 49
    }
    
    var additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return extraHeight + largeTitleHeight
        } else {
            return extraHeight
        }
    }
}
