// 
//  UINavigationController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/27
//  
//

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let bar = topViewController?.each_navigationBar else { return }
        
        if #available(iOS 11.0, *) {
            bar.prefersLargeTitles = navigationBar.prefersLargeTitles
            bar.largeTitleTextAttributes = navigationBar.largeTitleTextAttributes
        }
        
        if bar.isUnrestoredWhenViewWillLayoutSubviews {
            bar.frame.size = navigationBar.frame.size
        } else {
            bar.frame = navigationBar.frame
            if #available(iOS 11.0, *) {
                if bar.prefersLargeTitles {
                    bar.frame.origin.y = UIApplication.shared.statusBarFrame.maxY
                }
            }
        }
        bar.frame.size.height = navigationBar.frame.height + bar.extraHeight
    }
}
