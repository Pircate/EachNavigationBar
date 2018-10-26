//
//  Navigation+UIViewController.swift
//  EachNavigationBar
//
//  Created by Pircate on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

public extension Navigation where Base: UIViewController {
    
    var bar: EachNavigationBar {
        return base.each_navigationBar
    }
    
    var item: UINavigationItem {
        return base.each_navigationItem
    }
    
    func setShadowHidden(_ hidden: Bool) {
        let image = hidden ? UIImage() : nil
        base.each_navigationBar.shadowImage = image
        guard #available(iOS 11.0, *) else {
            base.each_navigationBar.setBackgroundImage(image, for: .default)
            return
        }
    }
}
