// 
//  UINavigationController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/27
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard _configuration.isEnabled else { return }
        
        sendNavigationBarToBack()
        
        guard let bar = topViewController?._navigationBar else { return }
        
        isNavigationBarHidden = false
        navigationBar.isHidden = bar.isHidden
        
        if bar.isUnrestoredWhenViewWillLayoutSubviews {
            bar.frame.size = navigationBar.frame.size
        } else {
            bar.frame = navigationBar.frame
            if #available(iOS 11.0, *) {
                if bar.prefersLargeTitles {
                    bar.frame.origin.y = CGFloat.StatusBar.maxY
                }
            }
        }
        
        bar.frame.size.height = navigationBar.frame.height + bar.additionalHeight
    }
    
    func sendNavigationBarToBack() {
        navigationBar.tintColor = UIColor.clear
        if navigationBar.shadowImage == nil {
            let image = UIImage()
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = image
            navigationBar.backIndicatorImage = image
            navigationBar.backIndicatorTransitionMaskImage = image
        }
        view.sendSubviewToBack(navigationBar)
    }
}
