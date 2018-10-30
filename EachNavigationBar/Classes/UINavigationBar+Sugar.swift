// 
//  UINavigationBar+Sugar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/30
//  Copyright © 2018年 Pircate. All rights reserved.
//

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
