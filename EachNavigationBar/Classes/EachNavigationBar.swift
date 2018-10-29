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
            if #available(iOS 11.0, *) {
                frame.size.height = 44.0 + largeTitleHeight + extraHeight
            } else {
                frame.size.height = 44.0 + extraHeight
            }
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
            frame.size.height =  44.0 + largeTitleHeight + extraHeight
        }
    }
    
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
}

extension UINavigationBar {
    
    @objc public func setTitleAlpha(_ alpha: CGFloat) {
        if var titleTextAttributes = titleTextAttributes {
            let color = titleTextAttributes[.foregroundColor] as? UIColor ?? UIColor.black
            titleTextAttributes[.foregroundColor] = color.withAlphaComponent(alpha)
            self.titleTextAttributes = titleTextAttributes
        } else {
            self.titleTextAttributes = [.foregroundColor: UIColor.black.withAlphaComponent(alpha)]
        }
    }
    
    @available(iOS 11.0, *)
    @objc public func setLargeTitleAlpha(_ alpha: CGFloat) {
        if var largeTitleTextAttributes = largeTitleTextAttributes {
            let color = largeTitleTextAttributes[.foregroundColor] as? UIColor ?? UIColor.black
            largeTitleTextAttributes[.foregroundColor] = color.withAlphaComponent(alpha)
            self.largeTitleTextAttributes = largeTitleTextAttributes
        } else {
            self.largeTitleTextAttributes = [.foregroundColor: UIColor.black.withAlphaComponent(alpha)]
        }
    }
    
    @objc public func setTintAlpha(_ alpha: CGFloat) {
        tintColor = tintColor.withAlphaComponent(alpha)
    }
    
    @objc public func setShadowHidden(_ hidden: Bool) {
        let image = hidden ? UIImage() : nil
        shadowImage = image
        guard #available(iOS 11.0, *) else {
            setBackgroundImage(image, for: .default)
            return
        }
    }
}
