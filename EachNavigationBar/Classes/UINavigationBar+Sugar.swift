// 
//  UINavigationBar+Sugar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/30
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UINavigationBar {
    
    private var defaultTitleColor: UIColor {
        return barStyle == .default ? UIColor.black : UIColor.white
    }
    
    @objc public func setTitleAlpha(_ alpha: CGFloat) {
        if var titleTextAttributes = titleTextAttributes {
            let color = titleTextAttributes[.foregroundColor] as? UIColor ?? defaultTitleColor
            titleTextAttributes[.foregroundColor] = color.alpha(alpha)
            self.titleTextAttributes = titleTextAttributes
        } else {
            self.titleTextAttributes = [.foregroundColor: defaultTitleColor.alpha(alpha)]
        }
    }
    
    @available(iOS 11.0, *)
    @objc public func setLargeTitleAlpha(_ alpha: CGFloat) {
        if var largeTitleTextAttributes = largeTitleTextAttributes {
            let color = largeTitleTextAttributes[.foregroundColor] as? UIColor ?? defaultTitleColor
            largeTitleTextAttributes[.foregroundColor] = color.alpha(alpha)
            self.largeTitleTextAttributes = largeTitleTextAttributes
        } else {
            self.largeTitleTextAttributes = [.foregroundColor: defaultTitleColor.alpha(alpha)]
        }
    }
    
    @objc public func setTintAlpha(_ alpha: CGFloat) {
        tintColor = tintColor.alpha(alpha)
    }
}

private extension UIColor {
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}
